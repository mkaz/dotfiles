#!/bin/bash

# Install script for setting up a Debian server

UNAME=`uname`
cd $HOME

rm -f .profile
ln -s dotfiles/profile .profile

mkdir ~/bin/
mkdir ~/src/
mkdir ~/tmp/

## update & upgrade
sudo apt update && apt upgrade

## use stow to configure rcfiles
cd ~/dotfiles/

sudo apt install -y sudo zip curl wget ufw
sudo apt install -y build-essential pwgen htop autojump neofetch
sudo apt install -y net-tools dnsutils autossh apt-transport-https
sudo apt install -y ripgrep fzf figlet exa fd-find

# LAMP
echo "✔ Installing LAMP stack"
sudo apt install -y apache2
sudo apt install -y mariadb-client mariadb-server
sudo apt install -y php libapache2-mod-php php-cli php-curl php-gd php-imagick php-intl php-mbstring php-mysql php-xml
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
