# Dotfile completions
_dotfiles_completions() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=($(compgen -W 'clean edit help macos update' -- $cur))
}
complete -o default -F _dotfiles_completions dot

# NPM completions
if is-executable npm; then
  . <(npm completion)
fi
