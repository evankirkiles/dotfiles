#!/bin/bash
set -euo pipefail

# On the first chezmoi apply on a Linux host, preserve any pre-existing
# ~/.zprofile and ~/.zshrc (e.g. distro defaults) by renaming them to
# .local variants. The chezmoi-managed versions source those .local files,
# so user customizations and distro defaults keep working.
#
# Skip files whose content already matches chezmoi's source state — that
# means chezmoi populated them on a previous apply, and migrating now
# would copy chezmoi's own content into the .local file (which itself
# sources .local, creating a loop).

for name in zprofile zshenv zshrc; do
  src="${HOME}/.${name}"
  dst="${HOME}/.${name}.local"
  [[ -f "$src" ]] || continue
  [[ -f "$dst" ]] && continue
  expected="$(chezmoi cat "$src" 2>/dev/null || true)"
  actual="$(cat "$src")"
  if [[ "$expected" == "$actual" ]]; then
    continue
  fi
  echo "Preserving existing ~/.${name} as ~/.${name}.local"
  mv "$src" "$dst"
done
