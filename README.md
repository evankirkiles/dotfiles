# evan dotfiles

Managed by Chezmoi. Should be simple enough to use:

```shell
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply evankirkiles
```

### Useful Commands

Changed `.chezmoi.toml.tmpl`:

```shell
chezmoi init
```

Updated LazyVim dependencies and want to pull in all new changes:

```shell
chezmoi re-add
```
