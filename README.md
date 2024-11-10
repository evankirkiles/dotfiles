# Evan's Dotfiles

Dotfiles which work for me :) An adaptation of [webpro/dotfiles](https://github.com/webpro/dotfiles)

## Installation

On a sparkling fresh installation of macOS:

```bash
sudo softwareupdate -i -a
xcode-select --install
```

The Xcode Command Line Tools includes `git` and `make` (not available on stock macOS). Now there are two options:

1. Install this repo with `curl` available:

```bash
bash -c "`curl -fsSL https://raw.githubusercontent.com/webpro/dotfiles/master/remote-install.sh`"
```

This will clone or download this repo to `~/.dotfiles` (depending on the availability of `git`, `curl` or `wget`).

1. Alternatively, clone manually into the desired location:

```bash
git clone https://github.com/webpro/dotfiles.git ~/.dotfiles
```

2. Use the [Makefile](./Makefile) to install the [packages listed above](#packages-overview), and symlink
   [runcom](./runcom) and [config](./config) files (using [stow](https://www.gnu.org/software/stow/)):

```bash
cd ~/.dotfiles
make
```

Running `make` with the Makefile is idempotent. The installation process in the Makefile is tested on every push and every week in this
[GitHub Action](https://github.com/webpro/dotfiles/actions). Please file an issue this repo if there are errors.

## Post-Installation

1. Set your Git credentials:

```sh
git config --global user.name "your name"
git config --global user.email "your@email.com"
git config --global github.user "your-github-username"
```

2. Set macOS and [system defaults](./macos/defaults.sh):

```sh
dot dock
dot macos
```

3. Start Hammerspoon once and set "Launch Hammerspoon at login".

4. Populate this file with tokens (example: `export GITHUB_TOKEN=abc`):

```sh
touch ~/.dotfiles/system/.exports
```

## The `dot` command

```
$ dot help
Usage: dot <command>

Commands:
   clean            Clean up caches (brew, cargo, gem, pip)
   edit             Open dotfiles in IDE ($VISUAL) and Git GUI ($VISUAL_GIT)
   help             This help message
   macos            Apply macOS system defaults
   update           Update packages and pkg managers
```

## Credits

Structure is that of: [webpro/dotfiles](https://github.com/webpro/dotfiles)
