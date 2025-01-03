#!/bin/bash

# Start with system path
is-executable getconf && PATH=$($(command -v getconf) PATH)

HOMEBREW_PREFIX=$("$DOTFILES_DIR"/bin/is-supported "$DOTFILES_DIR"/bin/is-arm64 /opt/homebrew /usr/local)

# Function for easily updating the path, making sure directoy exists
prepend-path() {
  [ -d "$1" ] && PATH="$1:$PATH"
}

# Now configure the paths
prepend-path "/bin"
prepend-path "/sbin"
prepend-path "/usr/bin"
prepend-path "/usr/sbin"
prepend-path "/usr/local/bin"
prepend-path "/usr/local/sbin"
prepend-path "$HOMEBREW_PREFIX/bin"
prepend-path "$HOMEBREW_PREFIX/sbin"
prepend-path "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin"
prepend-path "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin"
prepend-path "$HOMEBREW_PREFIX/opt/grep/libexec/gnubin"
prepend-path "$DOTFILES_DIR/bin"
prepend-path "$HOME/.cargo/bin"

# Remove duplicates (preserving prepended items)
# Source: http://unix.stackexchange.com/a/40755
PATH=$(echo -n "$PATH" | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}')

# Wrap up
export HOMEBREW_PREFIX
export PATH
