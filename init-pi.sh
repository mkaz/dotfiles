#!/bin/bash

# Install script for setting up a Raspberry Pi

UNAME=`uname`
cd $HOME

rm -f .profile
ln -s dotfiles/profile .profile

mkdir ~/bin/
mkdir ~/src/
mkdir ~/tmp/
mkdir ~/.config/

## update & upgrade
sudo apt update && sudo apt upgrade

sudo apt install -y git sudo zip curl wget neovim
sudo apt install -y build-essential pwgen htop autojump neofetch
sudo apt install -y net-tools dnsutils autossh apt-transport-https
sudo apt install -y ripgrep fzf figlet jq exa

# link up configs
ln -s $HOME/dotfiles/configs/git/gitattributes $HOME/.gitattributes
ln -s $HOME/dotfiles/configs/git/gitconfig $HOME/.gitconfig
ln -s $HOME/dotfiles/configs/git/gitignore $HOME/.gitignore

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y

# LAMP
read -p "Install LAMP Stack? (Y/n) " lamp
if [ "$lamp" != "${lamp#[Nn]}" ]; then
	echo "✖ Skipping LAMP"
else
	echo "✔ Installing LAMP Stack"
    sudo apt install -y apache2
    sudo apt install -y mariadb-client mariadb-server
    sudo apt install -y php libapache2-mod-php php-cli php-curl php-gd php-imagick php-intl php-mbstring php-mysql php-xml
    sudo a2enmod rewrite expires vhost_alias ssl headers
fi

# wp cli
if [ ! -f "$HOME/bin/wp" ]; then
    cd $HOME/tmp/
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    cp wp-cli.phar $HOME/bin/wp
    cd
fi

