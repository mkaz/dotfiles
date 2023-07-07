#!/bin/bash

# Install script for setting up my Ubuntu

UNAME=`uname`
cd $HOME

rm -f .profile
ln -s dotfiles/profile .profile
ln -s ~/Documents/Sync/pass-store .password-store

mkdir ~/bin/
mkdir ~/src/
mkdir ~/tmp/
mkdir ~/Downloads/

## update & upgrade
sudo apt update && sudo apt upgrade -y

## use stow to configure rcfiles
cd ~/dotfiles/

sudo apt install -y git zip curl wget ufw neovim neovim-qt
sudo apt install -y build-essential pwgen htop pass autojump neofetch uuid-runtime
sudo apt install -y net-tools dnsutils autossh apt-transport-https syncthing
sudo apt install -y gnome-tweaks gnome-shell-pomodoro gnome-dictionary
sudo apt install -y bat exa fzf fzy ripgrep
sudo apt install -y fonts-hack fonts-ibm-plex fonts-cabin fonts-roboto fonts-noto-color-emoji

# link up configs
ln -s $HOME/dotfiles/configs/git/gitattributes $HOME/.gitattributes
ln -s $HOME/dotfiles/configs/git/gitconfig $HOME/.gitconfig
ln -s $HOME/dotfiles/configs/git/gitignore $HOME/.gitignore

# symlink config
mkdir -p $HOME/.config
ln -s $HOME/dotfiles/configs/nvim $HOME/.config/nvim


# enable and start syncthing
sudo systemctl enable syncthing@mkaz.service
sudo systemctl start syncthing@mkaz.service

# configure firewall
sudo ufw allow ssh
sudo ufw limit ssh
sudo ufw allow 22000        # syncthing
sudo ufw allow 21027/udp    # syncthing
sudo ufw enable

# Python
sudo apt install -y python3-pip

# espanso
# wget https://github.com/federico-terzi/espanso/releases/latest/download/espanso-debian-amd64.deb
# sudo apt install -y ./espanso-debian-amd64.deb


