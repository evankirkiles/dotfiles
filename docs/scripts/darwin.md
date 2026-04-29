# darwin scripts

Scripts in this directory run on macOS hosts during `chezmoi apply`.

## Execution order

Chezmoi groups scripts by phase (`before` → file apply → `after`) and runs
them alphabetically by name within each phase. Scripts with no `before`/`after`
keyword fall into the default `after` bucket. The numeric prefixes on the
after-phase scripts force the install order described below.

1. **`run_once_before_install-brew.sh`** *(before phase)*
   Installs Homebrew if it's not already on the machine, then sources
   `brew shellenv` so subsequent steps can find `brew` on `PATH`. Runs once
   per machine.

2. *(chezmoi applies dotfiles)*

3. **`run_onchange_10-install-packages.sh.tmpl`** *(after phase)*
   Runs `brew bundle` against a Brewfile templated from
   `.chezmoidata/packages.yaml` (taps, brews, casks, mas apps). Must run
   before macos-defaults so the apps it references (Hammerspoon, Karabiner,
   Shottr) and the CLIs the signing-key script needs (`bw`, `jq`) are
   installed. Re-runs whenever the rendered template content changes.

4. **`run_once_after_20-apply-macos-defaults.sh`** *(after phase)*
   Applies `defaults write` settings for Finder, Dock, keyboard, screenshots,
   localization, etc., adds login items pointing to `/Applications/{Hammerspoon,
   Karabiner-Elements, Shottr}.app`, and kills affected apps so changes take
   effect. Depends on step 3 having installed those casks. Runs once per
   machine; gated by a sentinel at
   `$XDG_STATE_HOME/dotfiles/macos-defaults-applied` (set `FORCE=1` or delete
   the sentinel to re-run).

5. **`run_once_after_30-sync-signing-key.sh`** *(after phase)*
   Fetches the git signing SSH key from Bitwarden (`Git Signing Key` item by
   default; override with `SIGNING_KEY_BW_ITEM`), writes it to
   `~/.ssh/signing_ed25519{,.pub}`, and adds it to ssh-agent with
   `--apple-use-keychain` so the passphrase is stored in the login keychain.
   Depends on `bw` and `jq` from step 3. Idempotent — bails if the key
   already exists; pass `--force` to refresh.

## Adding a new script

The numeric prefixes (`10`, `20`, `30`) determine intra-phase order. Use
widely-spaced numbers so new scripts can slot in without renaming
(e.g. `15-foo.sh` to run between packages and macos-defaults). Note: chezmoi
tracks `run_onchange_*` state by filename + content hash, so renaming one
causes it to re-run once on the next apply. `run_once_*` scripts are tracked
by content hash alone, so renames don't re-trigger them.
