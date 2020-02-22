#!/bin/bash

# Install script for setting up my Manjaro linux

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
stow rcfiles

sudo apt install -y git sudo zip curl wget ufw vim-nox
sudo apt install -y build-essential stow pwgen htop autojump neofetch
sudo apt install -y net-tools dnsutils autossh apt-transport-https
sudo apt install -y ripgrep fzf figlet

# LAMP
read -p "Install LAMP Stack? (Y/n) " lamp
if [ "$lamp" != "${lamp#[Nn]}" ]; then
	echo "✖ Skipping LAMP"
else
	echo "✔ Installing Sublime Text"
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
