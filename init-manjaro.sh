#!/bin/bash

# Install script for setting up my Manjaro linux

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
sudo pacman -Syu


## use stow to configure rcfiles
cd ~/dotfiles/
stow rcfiles

#  _               _
# | |__   __ _ ___(_) ___ ___
# | '_ \ / _` / __| |/ __/ __|
# | |_) | (_| \__ \ | (__\__ \
# |_.__/ \__,_|___/_|\___|___/

## double check we have these, installed with manjaro
sudo pacman -S --needed --noconfirm git sudo zip curl wget ufw vim yay

sudo pacman -S --needed --noconfirm base-devel stow pwgen net-tools dnsutils htop pass autojump neofetch autossh
sudo pacman -S --needed --noconfirm imagemagick pngcrush pandoc gifsicle figlet
sudo pacman -S --needed --noconfirm ripgrep fzf newsboat

# gui: photo and video
sudo pacman -S --needed --noconfirm rapid-photo-downloader geeqie peek gpick

# gui: fonts
mkdir ~/.fonts
cd ~/.fonts
unzip $HOME/dotfiles/extras/fonts.zip
cd

# syncthing
if [ ! -f "$HOME/bin/syncthing" ]; then
    cd $HOME/Downloads
    wget https://github.com/syncthing/syncthing/releases/download/v1.2.0/syncthing-linux-amd64-v1.2.0.tar.gz
    tar xfz syncthing-linux-amd64-v1.2.0.tar.gz
    cp syncthing-linux-amd64-v1.2.0/syncthing $HOME/bin/
    #TODO: add to GNOME startup items
    cd
fi

# Software installs
sudo yay -S slack-desktop

# Node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash

# Golang
sudo pacman -S --noconfirm go

# LAMP
sudo pacman -S --needed --noconfirm apache
sudo systemctl enable httpd
sudo systemctl restart httpd

sudo pacman -S --needed --noconfirm mysql
sudo systemctl enable mysqld
sudo systemctl restart mysqld

sudo pacman -S --needed --noconfirm php php-apache php-intl php-gd php-imagick

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
sudo ufw allow 22000        # syncthing
sudo ufw allow 21027/udp    # syncthing
sudo ufw enable

#        _ _
#   __ _(_) |_
#  / _` | | __|
# | (_| | | |_
#  \__, |_|\__|
#  |___/

# install hub
GOPATH=/home/mkaz go get github.com/github/hub

# git-revise
# sudo apt-get -y install python3-pip
# python3 -m pip install --user git-revise

# sublime text
curl -O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key --add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg
echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/stable/x86_64" | sudo tee -a /etc/pacman.conf
pacman -Syu --noconfirm sublime-text

