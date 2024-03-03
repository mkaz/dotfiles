#!/bin/bash

# Install script for setting up macOS

rm -f .profile

mkdir ~/bin/
mkdir ~/src/
mkdir ~/tmp/
mkdir ~/Downloads/

## Install homebrew

# Basics
brew install coreutils eza fd fzf just ripgrep sd starship zoxide
# after install
/opt/homebrew/opt/fzf/install

# Password store
brew install pass
ln -s ~/Documents/Sync/pass-store .password-store

# Git setup
ln -s $HOME/dotfiles/configs/git/gitattributes $HOME/.gitattributes
ln -s $HOME/dotfiles/configs/git/gitconfig $HOME/.gitconfig
ln -s $HOME/dotfiles/configs/git/gitignore $HOME/.gitignore

# Neovim
brew install neovim
mkdir -p $HOME/.config
ln -s $HOME/dotfiles/configs/nvim $HOME/.config/nvim

# Fonts
brew install --cask homebrew/cask-fonts/font-hack

# Install Node using volta
# curl https://get.volta.sh | bash"

# Python ---------------------------------
# TODO: Install python
python3 -m pip install neovim
python3 -m pip install 'xonsh[full]'

# Ruff
brew install ruff

# Raycast
# Syncthing
# 1Passwd
# Moom
# Kitty

# Firefox
# Obsidian
# Slack
