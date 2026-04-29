# evan dotfiles

Managed by [chezmoi](https://chezmoi.io). Bootstrap a fresh macOS machine with a
single command:

```shell
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply evankirkiles
```

That installs chezmoi, clones this repo, then runs `chezmoi apply`, which:

1. Installs Homebrew (and Xcode Command Line Tools) if missing
2. Runs `brew bundle` against `home/.chezmoidata/packages.yaml`
3. Clones oh-my-zsh and its plugins as real git repos under `~/.oh-my-zsh`
4. Writes `~/.ssh/known_hosts` pre-seeded with GitHub's published keys
5. Applies macOS system defaults (Finder, Dock, key repeat, login items, …)
   and points Hammerspoon at `~/.config/hammerspoon/init.lua`
6. Fetches the git signing key from Bitwarden via `bin/signing-key-sync`

## Interactive prompts you should expect on first run

The `chezmoi apply` is mostly hands-off but has a few unavoidable prompts:

- **Xcode Command Line Tools install dialog** — click "Install" once; the
  Homebrew installer waits for it to finish.
- **`sudo` password** — needed for the macOS defaults (timezone, pmset, etc.).
- **Bitwarden login/unlock** — `signing-key-sync` runs `bw login` then
  `bw unlock` interactively to fetch the SSH signing key.

## Things still done by hand (OS-level permissions)

- **Hammerspoon Accessibility** — grant in System Settings → Privacy &
  Security → Accessibility, then reload Hammerspoon. `mash` keybinds won't
  fire until this is done.
- **Karabiner-Elements** driver, Input Monitoring, and Accessibility prompts.
- **Mac App Store sign-in** — `mas install` lines in `brew bundle` will fail
  silently if you aren't signed in to the App Store first.

## Useful commands

Changed `.chezmoi.toml.tmpl`:

```shell
chezmoi init
```

Re-apply macOS defaults (guarded by a sentinel so editing the script alone
won't re-trigger it):

```shell
rm -f "${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles/macos-defaults-applied"
chezmoi state delete-bucket --bucket=scriptState && chezmoi apply
```

Or run the script directly with `FORCE=1`:

```shell
FORCE=1 ~/.local/share/chezmoi/home/.chezmoiscripts/darwin/run_once_after_apply-macos-defaults.sh
```

Force re-fetch the signing key from Bitwarden:

```shell
~/bin/signing-key-sync --force
```

Updated LazyVim dependencies and want to pull in all new changes:

```shell
chezmoi re-add
```
