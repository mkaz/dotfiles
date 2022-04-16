#!/bin/bash

# Install script for setting up macOS

rm -f .profile
ln -s dotfiles/profile .profile

mkdir ~/bin/
mkdir ~/src/
mkdir ~/tmp/
mkdir ~/Downloads/

## Install homebrew

# Basics
brew install autojump bat exa fd jq just ripgrep sd starship

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
# curl https://get.volta.sh | bash

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# espanso

