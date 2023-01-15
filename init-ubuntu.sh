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

sudo apt install -y git git-lfs sudo zip curl wget ufw neovim neovim-qt
sudo apt install -y build-essential stow pwgen htop pass autojump neofetch
sudo apt install -y net-tools dnsutils autossh apt-transport-https syncthing
sudo apt install -y gnome-tweaks gnome-shell-pomodoro gnome-dictionary
sudo apt install -y bat exa fd fzf jq ripgrep 

# link up configs
ln -s $HOME/dotfiles/configs/git/gitattributes $HOME/.gitattributes
ln -s $HOME/dotfiles/configs/git/gitconfig $HOME/.gitconfig
ln -s $HOME/dotfiles/configs/git/gitignore $HOME/.gitignore

# symlink config
mkdir -p $HOME/.config
ln -s $HOME/dotfiles/configs/nvim $HOME/.config/nvim

# gui: photo and video
read -p "Install Photo & Video? (N/y) " media
if [ "$media" != "${media#[Yy]}" ]; then
    sudo apt install -y imagemagick pngcrush pandoc gifsicle flameshot
    sudo apt install -y rapid-photo-downloader geeqie peek gpick 
fi

# gui: fonts
read -p "Install Fonts? (N/y) " fonts
if [ "$fonts" != "${fonts#[Yy]}" ]; then
	sudo apt install -y fonts-hack fonts-ibm-plex fonts-noto fonts-roboto fonts-noto-color-emoji
fi

#----------------------------------------

# Install Node using volta
curl https://get.volta.sh | bash

# enable and start syncthing
sudo systemctl enable syncthing@mkaz.service
sudo systemctl start syncthing@mkaz.service

# LAMP (use Local?)
read -p "Install LAMP Stack? (Y/n) " lamp
if [ "$lamp" != "${lamp#[Nn]}" ]; then
	echo "✖ Skipping LAMP"
else
	echo "✔ Installing LAMP"
    sudo apt install -y apache2
    sudo apt install -y mariadb-client mariadb-server
    sudo apt install -y php libapache2-mod-php php-cli php-curl php-gd php-imagick php-intl php-mbstring php-mysql php-xml
    sudo a2enmod rewrite expires vhost_alias ssl headers
fi

# wp cli
if [ ! -f "$HOME/bin/wp" ]; then
    cd $HOME/Downloads
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    cp wp-cli.phar $HOME/bin/wp
    cd
fi

# configure firewall
sudo ufw allow ssh
sudo ufw limit ssh
sudo ufw allow 22000        # syncthing
sudo ufw allow 21027/udp    # syncthing
sudo ufw enable

# disable printer auto discovery
# easier to configure and setup manually
sudo systemctl stop cups-browsed
sudo systemctl disable cups-browsed

# Software installs


cd $HOME/Downloads

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y

## install exa
wget https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip
unzip exa-linux-x86_64-0.9.0.zip
mv exa-linux-x86_64 ~/bin/exa

# espanso
wget https://github.com/federico-terzi/espanso/releases/latest/download/espanso-debian-amd64.deb
sudo apt install -y ./espanso-debian-amd64.deb


