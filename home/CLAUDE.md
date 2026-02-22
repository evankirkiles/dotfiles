# Claude Instructions

## Dotfile Management

I use [chezmoi](https://chezmoi.io) to manage dotfiles. When editing any dotfile
(e.g. `~/.zshrc`, `~/.config/*`, `~/.claude/*`, etc.), make changes via chezmoi:

- Edit the source file: `chezmoi edit <file>`
- Or edit the source directory directly: `~/.local/share/chezmoi/`
- After editing, apply with: `chezmoi apply`

Do not directly edit files in `~` that are managed by chezmoi, as changes will
be overwritten on the next `chezmoi apply`.
