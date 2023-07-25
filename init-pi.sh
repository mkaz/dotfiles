#!/bin/bash

# Install script for setting up a Raspberry Pi

UNAME=`uname`
cd $HOME

#rm -f .profile
#ln -s dotfiles/profile .profile

mkdir ~/bin/
mkdir ~/src/
mkdir ~/tmp/
mkdir ~/.config/

## update & upgrade
sudo apt update && sudo apt upgrade

sudo apt install -y git sudo zip curl wget htop autojump neofetch
sudo apt install -y ufw net-tools dnsutils 
sudo apt install -y ripgrep fzf figlet

# link up configs
ln -s $HOME/dotfiles/configs/git/gitattributes $HOME/.gitattributes
ln -s $HOME/dotfiles/configs/git/gitconfig $HOME/.gitconfig
ln -s $HOME/dotfiles/configs/git/gitignore $HOME/.gitignore
ln -s $HOME/dotfiles/configs/vimrc $HOME/.vimrc

sudo ufw allow ssh
sudo ufw limit ssh
sudo ufw allow 80           # http
sudo ufw enable

