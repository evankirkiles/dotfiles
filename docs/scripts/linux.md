# linux scripts

Scripts in this directory run on Linux hosts during `chezmoi apply`.

## Execution order

Chezmoi groups scripts by phase (`before` → file apply → `after`) and runs
them alphabetically by name within each phase. Scripts with no `before`/`after`
keyword fall into the default `after` bucket. The numeric prefixes on the
`onchange` scripts force the install order described below.

1. **`run_once_before_migrate-shell-files.sh`** *(before phase)*
   On the first apply on a new Linux host, renames any pre-existing
   `~/.zprofile`, `~/.zshenv`, `~/.zshrc` to `*.local` so the chezmoi-managed
   versions (which `source` the `.local` files) preserve distro defaults and
   user customizations. Skips files that already match chezmoi's source state
   to avoid creating a `.local` → `.local` source loop.

2. *(chezmoi applies dotfiles)*

3. **`run_onchange_10-install-packages.sh.tmpl`** *(after phase)*
   `apt-get update` + installs the package list templated from
   `.chezmoidata/packages.yaml` (`packages.linux.apt`). Also installs the
   GitHub CLI from the official apt repo and symlinks `fdfind` → `fd` for
   muscle memory. No-ops on non-Debian distros (no `apt-get`).

4. **`run_onchange_20-install-rust.sh`** *(after phase)*
   Installs `libclang-dev` (needed by bindgen-using crates), bootstraps
   `rustup`/`cargo` if missing, sets the stable toolchain as default, then
   `cargo install tree-sitter-cli` (newer than distro packages). Depends on
   apt being primed by step 3.

5. **`run_onchange_30-install-neovim.sh`** *(after phase)*
   Pins neovim to a specific version (currently `v0.12.0`) by downloading the
   official linux-x86_64 tarball into `~/.local/opt/nvim-<version>` and
   symlinking the binary into `~/.local/bin/nvim`. Skips if the desired
   version is already installed.

## Adding a new script

The numeric prefixes (`10`, `20`, `30`) determine intra-phase order. Use
widely-spaced numbers so new scripts can slot in without renaming
(e.g. `15-foo.sh` to run between packages and rust). Note: chezmoi tracks
`run_onchange_*` state by filename + content hash, so renaming one causes
it to re-run once on the next apply. `run_once_*` scripts are tracked by
content hash alone, so renames don't re-trigger them.
