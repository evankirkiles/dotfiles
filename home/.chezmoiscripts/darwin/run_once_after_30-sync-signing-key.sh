#!/usr/bin/env bash
# Fetch the git signing SSH key from Bitwarden and install it under ~/.ssh/.
# Idempotent — bails out if the key files already exist (use --force to refresh).
set -euo pipefail

ITEM_NAME="${SIGNING_KEY_BW_ITEM:-Git Signing Key}"
PRIV="$HOME/.ssh/signing_ed25519"
PUB="$PRIV.pub"
FORCE=0

usage() {
  cat <<EOF
Usage: $(basename "$0") [--force]

Fetches "$ITEM_NAME" from Bitwarden (override with SIGNING_KEY_BW_ITEM env var)
and writes its private + public keys to ~/.ssh/signing_ed25519{,.pub}.

After fetching, the key is added to the SSH agent and the passphrase (if any)
is stored in the macOS login keychain via --apple-use-keychain.

Options:
  --force    Overwrite existing key files.
EOF
}

for arg in "$@"; do
  case "$arg" in
    -h|--help) usage; exit 0 ;;
    --force) FORCE=1 ;;
    *) echo "Unknown arg: $arg" >&2; usage >&2; exit 2 ;;
  esac
done

for cmd in bw jq; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "error: $cmd not found on PATH" >&2
    exit 1
  fi
done

if [[ -f "$PRIV" && $FORCE -eq 0 ]]; then
  echo "Key already present at $PRIV (use --force to overwrite)."
  exit 0
fi

# Make sure bw is unlocked. Prompts the user interactively when not.
status="$(bw status | jq -r '.status')"
if [[ "$status" == "unauthenticated" ]]; then
  echo "Logging in to Bitwarden (interactive)..."
  bw login
  status="$(bw status | jq -r '.status')"
fi
if [[ "$status" == "locked" ]]; then
  echo "Unlocking Bitwarden..."
  BW_SESSION="$(bw unlock --raw)"
  export BW_SESSION
fi

echo "Fetching '$ITEM_NAME' from Bitwarden..."
item_json="$(bw get item "$ITEM_NAME")"

priv_key="$(jq -r '.sshKey.privateKey // empty' <<<"$item_json")"
pub_key="$(jq -r '.sshKey.publicKey // empty' <<<"$item_json")"
passphrase="$(jq -r '.fields[]? | select(.name=="passphrase") | .value // empty' <<<"$item_json")"

if [[ -z "$priv_key" || -z "$pub_key" ]]; then
  echo "error: item '$ITEM_NAME' has no .sshKey.privateKey/.publicKey fields" >&2
  echo "       (is it an SSH Key item type?)" >&2
  exit 1
fi

mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

umask 077
printf '%s\n' "$priv_key" >"$PRIV"
chmod 600 "$PRIV"

printf '%s\n' "$pub_key" >"$PUB"
chmod 644 "$PUB"

echo "Wrote $PRIV and $PUB."

# Add to ssh-agent and stash the passphrase in the login keychain on first
# add via --apple-use-keychain. SSH_ASKPASS feeds the passphrase
# non-interactively so this script can run unattended (e.g. under chezmoi).
if [[ -n "$passphrase" ]]; then
  askpass="$(mktemp "${TMPDIR:-/tmp}/ssh-askpass.XXXXXX")"
  trap 'rm -f "$askpass"' EXIT
  cat >"$askpass" <<'EOF'
#!/bin/sh
printf '%s\n' "$SSH_PASSPHRASE"
EOF
  chmod 700 "$askpass"
  SSH_PASSPHRASE="$passphrase" \
    DISPLAY=:0 \
    SSH_ASKPASS="$askpass" \
    SSH_ASKPASS_REQUIRE=force \
    ssh-add --apple-use-keychain "$PRIV" </dev/null
else
  ssh-add --apple-use-keychain "$PRIV" 2>/dev/null || ssh-add "$PRIV"
fi

echo "Done. Test with: git -c user.signingkey=\"$PUB\" commit --allow-empty -m test"
