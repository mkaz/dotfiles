#!/bin/bash

# Manjaro GNOME setup

UNAME=`uname`
cd $HOME

rm -f .profile
ln -s dotfiles/profile .profile
echo "source $HOME/.profile >>$HOME/.bashrc"

dirs=("$HOME/bin $HOME/.fonts $HOME/src $HOME/tmp $HOME/Downloads $HOME/.npm-global")
for d in "${dirs[@]}"; do
    mkdir $d
done

## update & upgrade
sudo pacman -Syu --noconfirm

## setup the basics
sudo pacman -S --noconfirm binutils make ctags
sudo pacman -S --noconfirm stow pwgen net-tools dnsutils htop autossh 
sudo pacman -S --noconfirm pass autojump task neofetch ripgrep gvim
sudo pacman -S --noconfirm pngcrush pandoc peek gpick cowsay figlet noto-fonts-emoji
sudo pacman -S --noconfirm newsboat albert muparser

## Setup configs
cd $HOME/dotfiles/
stow rcfiles
ln -s $HOME/Documents/Sync/pass-store $HOME/.password-store

# syncthing
sudo pacman -S --noconfirm syncthing
sudo systemctl enable syncthing@mkaz.service
sudo systemctl start syncthing@mkaz.service

cd $HOME/.fonts
unzip $HOME/dotfiles/extras/fonts.zip

# Settings
# gnome-terminal colorscheme
/bin/bash $HOME/dotfiles/extras/gnome-terminal-onedark.sh
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
rm $HOME/.config/autostart/create-template.desktop

# Programming
sudo pacman -S --noconfirm nodejs go
npm config set prefix "$HOME/.npm-global"

# LAMP
sudo pacman -S --noconfirm mariadb memcached apache
sudo pacman -S --noconfirm php composer php-memcached php-intl php-apache php-imagick

# Apache
sudo systemctl enable httpd
sudo systemctl start httpd

# MariaDB
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl enable mysqld
sudo systemctl start mysqld

# wp cli
if [ ! -f "$HOME/bin/wp" ]; then
    cd $HOME/Downloads
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar $HOME/bin/wp
fi

# configure firewall
sudo ufw allow ssh
sudo ufw limit ssh
#sudo ufw allow 80
sudo ufw enable

# install hub
GOPATH=/home/mkaz go get github.com/github/hub
GOPATH=/home/mkaz go get github.com/mkaz/hastie
GOPATH=/home/mkaz go get github.com/mkaz/wpsync

