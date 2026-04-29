#!/bin/bash
set -euo pipefail

# Skip if apt-get isn't available (non-Debian-family distro).
command -v apt-get >/dev/null 2>&1 || exit 0

SUDO=""
if [[ $EUID -ne 0 ]]; then
  SUDO="sudo"
fi

# libclang is required by Rust crates that use bindgen.
$SUDO apt-get update
$SUDO apt-get install -y libclang-dev

# Install rustup (and cargo) if missing.
if ! command -v cargo >/dev/null 2>&1 && [ ! -x "$HOME/.cargo/bin/cargo" ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs |
    sh -s -- -y --default-toolchain stable --no-modify-path
fi

# Make cargo available for the rest of this script.
export PATH="$HOME/.cargo/bin:$PATH"

rustup default stable

# tree-sitter-cli from crates.io is newer than what most distros package.
cargo install tree-sitter-cli
