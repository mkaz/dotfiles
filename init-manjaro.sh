#!/bin/bash

# Manjaro GNOME setup

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
sudo pacman -Sy

## setup the basics
sudo pacman -S stow

## use stow to configure rcfiles
cd ~/dotfiles/
stow rcfiles

#  _               _
# | |__   __ _ ___(_) ___ ___
# | '_ \ / _` / __| |/ __/ __|
# | |_) | (_| \__ \ | (__\__ \
# |_.__/ \__,_|___/_|\___|___/

sudo pacman -S ctags pwgen net-tools dnsutils htop autossh
sudo pacman -S pass autojump task neofetch ripgrep figlet
sudo pacman -S pngcrush pandoc peek gpick

mkdir ~/.fonts
cd ~/.fonts
unzip $HOME/dotfiles/extras/fonts.zip
cd

# syncthing
if [ ! -f "$HOME/bin/syncthing" ]; then
    cd $HOME/Downloads
    wget https://github.com/syncthing/syncthing/releases/download/v1.1.3/syncthing-linux-amd64-v1.1.3.tar.gz
    tar xfz syncthing-linux-amd64-v1.1.3.tar.gz
    cp syncthing-linux-amd64-v1.1.3/syncthing $HOME/bin/
    mkdir -p $HOME/.config/autostart
    cp $HOME/dotfiles/extras/autostart-syncthing.desktop $HOME/.config/autostart/syncthing.desktop
    cd
fi

# click to dock icon to minimize
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'

#  ___ _ __   __ _ _ __  ___
# / __| '_ \ / _` | '_ \/ __|
# \__ \ | | | (_| | |_) \__ \
# |___/_| |_|\__,_| .__/|___/
#                 |_|
sudo snap install slack --classic

# Node
cd $HOME/Downloads
curl --silent --location https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get -y install nodejs
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'

# Golang
sudo pacman -S go

# LAMP
sudo pacman -S mysql-client mysql-server memcached
sudo pacman -S php php-cli php-common php-curl php-dev php-memcached php-mysql php-json php-mbstring php-intl php-xml
sudo pacman -S apache2 libapache2-mod-php
sudo a2enmod rewrite expires vhost_alias ssl

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
#sudo ufw allow 80
sudo ufw enable

# install hub
GOPATH=/home/mkaz go get github.com/github/hub
GOPATH=/home/mkaz go get github.com/jesseduffield/lazygit

# vim: syntax=sh ts=4 sw=4 sts=4 sr et
