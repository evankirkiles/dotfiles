This directory contains relative symlinks to commonly-needed configuration directories and files which aren't managed by chezmoi, to make it easier to edit things without having to find them in the home directory.

To add a new file in here, make sure you relatively symlink it:

```bash
ln -s --relative ~/.zshrc.local ~/.local/share/chezmoi/links/.zshrc.local
```
