DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
OS := $(shell bin/is-supported bin/is-macos macos linux)
HOMEBREW_PREFIX := $(shell bin/is-supported bin/is-macos $(shell bin/is-supported bin/is-arm64 /opt/homebrew /usr/local) /home/linuxbrew/.linuxbrew)
PATH := $(HOMEBREW_PREFIX)/bin:$(DOTFILES_DIR)/bin:$(PATH)
SHELL := env PATH=$(PATH) /bin/bash
SHELLS := /private/etc/shells
BIN := $(HOMEBREW_PREFIX)/bin
NODE_VERSION := lts/iron
export XDG_CONFIG_HOME = $(HOME)/.config
export STOW_DIR = $(DOTFILES_DIR)
export ACCEPT_EULA=y
NVM_DIR := $(XDG_CONFIG_HOME)/nvm

.PHONY: test

# Entry points based on the platform
all: $(OS)

macos: sudo core-macos packages link

linux: core-linux link

# ===== INSTALLATION =======

# Install core requirements for development
core-macos: brew nvm zsh git rustup

core-linux:
	apt-get update
	apt-get upgrade -y
	apt-get dist-upgrade -f

# Installs all third-party packages
packages: brew-packages cask-apps node-packages rust-packages

# ===== CONFIGURATION =======

# Platform-specific installers for stow to manage symlinks
stow-macos: brew
	is-executable stow || brew install stow

stow-linux: core-linux
	is-executable stow || apt-get -y install stow

sudo:
ifndef GITHUB_ACTION
	sudo -v
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
endif

# Link/unlink symlinks for all configurations
link: stow-$(OS)
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE -a ! -h $(HOME)/$$FILE ]; then \
		mv -v $(HOME)/$$FILE{,.bak}; fi; done
	mkdir -p "$(XDG_CONFIG_HOME)"
	stow -t "$(HOME)" runcom
	stow -t "$(XDG_CONFIG_HOME)" config
	mkdir -p $(HOME)/.local/runtime
	chmod 700 $(HOME)/.local/runtime

unlink: stow-$(OS)
	stow --delete -t "$(HOME)" runcom
	stow --delete -t "$(XDG_CONFIG_HOME)" config
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE.bak ]; then \
    mv -v $(HOME)/$$FILE.bak $(HOME)/$${FILE%%.bak}; fi; done

# ==== PACKAGES ========

brew:
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash

# v20.18.0 LTS Node Version
nvm:
	test -f $(NVM_DIR)/nvm.sh || ( curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash && \
	. $(NVM_DIR)/nvm.sh && \
	nvm install $(NODE_VERSION) && \
	nvm alias default $(NODE_VERSION) )

rustup:
	is-executable rustup || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y

zsh: brew
	if ! grep -q zsh $(SHELLS); then \
	  brew install zsh && \
	  sudo append $(shell which zsh) $(SHELLS) && \
	  sudo chsh -s $(shell which zsh); \
	fi

git: brew
	brew install git git-extras

brew-packages: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile || true

cask-apps: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Caskfile || true

node-packages: nvm
	. $(NVM_DIR)/nvm.sh && \
	nvm use $(NODE_VERSION) && \
	npm install --force --location global $(shell cat install/npmfile)

rust-packages: rustup
	. "$(HOME)/.cargo/env" && \
	cargo install $(shell cat install/Rustfile)
