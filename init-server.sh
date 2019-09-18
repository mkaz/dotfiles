#!/bin/bash

# install script for setting up linux

UNAME=`uname`
cd $HOME

rm -f .profile
ln -s dotfiles/profile .profile

mkdir ~/bin/
mkdir ~/src/
mkdir ~/tmp/

## update & upgrade
sudo apt-get update
sudo apt-get -y upgrade

## double check we have these
sudo apt-get -y install git sudo zip stow vim vim-gtk3

## use stow to configure rcfiles
cd ~/dotfiles/
stow rcfiles

#  _               _
# | |__   __ _ ___(_) ___ ___
# | '_ \ / _` / __| |/ __/ __|
# | |_) | (_| \__ \ | (__\__ \
# |_.__/ \__,_|___/_|\___|___/

sudo apt-get -y install build-essential automake autoconf gnu-standards libtool gettext ctags curl wget pwgen net-tools dnsutils htop ufw autojump neofetch imagemagick pngcrush pandoc units figlet ruby-dev ripgrep fzf autossh

# Node
cd $HOME/Downloads
curl --silent --location https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get -y install nodejs
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'

# Golang
sudo apt-get -y install golang-go

# LAMP
#                    ()                   * )
#                   <^^>             *     (   .
#                  .-""-.                    )
#       .---.    ."-....-"-._     _...---''`/. '
#      ( (`\ \ .'            ``-''    _.-"'`
#       \ \ \ : :.                 .-'
#        `\`.\: `:.             _.'
#        (  .'`.`            _.'
#         ``    `-..______.-'
#                   ):.  (
#                 ."-....-".
#               .':.        `.
#               "-..______..-"
sudo apt-get -y install mysql-client mysql-server memcached
sudo apt-get -y install php php-cli php-common php-curl php-dev php-memcached php-mysql php-json php-mbstring php-intl php-xml php-gd php-imagick
sudo apt-get -y install apache2 libapache2-mod-php
sudo a2enmod rewrite expires vhost_alias ssl headers

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
sudo ufw allow 80
sudo ufw enable

