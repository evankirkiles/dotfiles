# evan dotfiles

Managed by [chezmoi](https://chezmoi.io). Bootstrap a fresh macOS or Linux
machine with one command:

```shell
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply evankirkiles
```

That installs chezmoi, clones this repo, and runs `chezmoi apply`. See
[`docs/scripts/darwin.md`](docs/scripts/darwin.md) and
[`docs/scripts/linux.md`](docs/scripts/linux.md) for the full per-OS script
sequence. Highlights:

- **macOS** — installs Homebrew + `brew bundle`s against
  `home/.chezmoidata/packages.yaml`, applies system defaults (Finder, Dock,
  key repeat, login items, Hammerspoon config path), and fetches the git
  signing key from Bitwarden.
- **Linux** — preserves any pre-existing `~/.zshrc`/`~/.zprofile` as
  `*.local`, installs apt packages + the GitHub CLI, bootstraps rustup +
  `tree-sitter-cli`, and pins a specific neovim release.

## Interactive prompts on first run

- **Xcode Command Line Tools install dialog** *(macOS)* — click "Install";
  the Homebrew installer waits for it.
- **`sudo` password** — for macOS defaults / `apt-get install`.
- **Bitwarden login/unlock** *(macOS)* — `bw login` then `bw unlock` to
  fetch the SSH signing key.

## Things still done by hand (macOS, OS-level permissions)

- **Hammerspoon Accessibility** — System Settings → Privacy & Security →
  Accessibility, then reload Hammerspoon. `mash` keybinds won't fire until
  this is done.
- **Karabiner-Elements** driver, Input Monitoring, and Accessibility prompts.
- **Mac App Store sign-in** — `mas install` lines fail silently otherwise.

## Useful commands

Re-init after editing `.chezmoi.toml.tmpl`:

```shell
chezmoi init
```

Re-apply macOS defaults (sentinel guards the script, chezmoi state guards
the invocation — clear both):

```shell
rm -f "${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles/macos-defaults-applied"
chezmoi state delete-bucket --bucket=scriptState && chezmoi apply
```

Or run the script directly with `FORCE=1`:

```shell
FORCE=1 ~/.local/share/chezmoi/home/.chezmoiscripts/darwin/run_once_after_20-apply-macos-defaults.sh
```

Force re-fetch the signing key from Bitwarden:

```shell
~/.local/share/chezmoi/home/.chezmoiscripts/darwin/run_once_after_30-sync-signing-key.sh --force
```

Updated LazyVim dependencies and want to pull in all new changes:

```shell
chezmoi re-add
```
