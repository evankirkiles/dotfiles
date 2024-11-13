# Use ~/.zprofile to set the PATH and EDITOR environment variables.
# And anything else that only needs to be set once on login.

# Resolve DOTFILES_DIR (assuming ~/.dotfiles on distros without readlink and/or $BASH_SOURCE/$0)
CURRENT_SCRIPT=$BASH_SOURCE
if [[ -n $CURRENT_SCRIPT && -x readlink ]]; then
  SCRIPT_PATH=$(readlink -n $CURRENT_SCRIPT)
  DOTFILES_DIR="${PWD}/$(dirname $(dirname $SCRIPT_PATH))"
elif [ -d "$HOME/.dotfiles" ]; then
  DOTFILES_DIR="$HOME/.dotfiles"
elif [ -d "$HOME/dotfiles" ]; then
  DOTFILES_DIR="$HOME/dotfiles"
else
  echo "Unable to find dotfiles, exiting."
  return
fi

# Make utilities available
PATH="$DOTFILES_DIR/bin:$PATH"

# Source our custom dotfiles
for DOTFILE in "$DOTFILES_DIR"/system/.{path,env,exports}.sh; do
  if [ -f "$DOTFILE" ]; then
    . "$DOTFILE"
  fi
done

# Source env variables from any programs
eval "$(brew shellenv)"
eval "$(dircolors -b "$DOTFILES_DIR"/system/.dir_colors)"

# Wrap up
unset CURRENT_SCRIPT SCRIPT_PATH DOTFILE
export DOTFILES_DIR
export PATH

