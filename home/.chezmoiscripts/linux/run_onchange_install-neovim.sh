#!/usr/bin/env bash
set -u
export PATH="$HOME/.local/bin:$PATH"

desired="v0.12.0"
if command -v nvim >/dev/null 2>&1; then
  current_version="$(nvim --version 2>/dev/null | head -n 1 | awk "{print \$2}")"
  if [[ "$current_version" == "$desired" ]]; then
    exit 0
  fi
fi

work_dir="$HOME/.cache/nvim-install-$desired"
tarball="$work_dir/nvim-linux-x86_64.tar.gz"
release_url="https://github.com/neovim/neovim-releases/releases/download/$desired/nvim-linux-x86_64.tar.gz"
install_dir="$HOME/.local/opt/nvim-$desired"

mkdir -p "$HOME/.local/bin" "$HOME/.local/opt" "$work_dir"
curl -fL --retry 3 --retry-delay 2 -o "$tarball" "$release_url"

rm -rf "$install_dir"
mkdir -p "$install_dir"
tar -xzf "$tarball" -C "$install_dir" --strip-components=1
ln -sf "$install_dir/bin/nvim" "$HOME/.local/bin/nvim"

current_version="$("$HOME/.local/bin/nvim" --version 2>/dev/null | head -n 1 | awk "{print \$2}")"
[[ "$current_version" == "$desired" ]]
