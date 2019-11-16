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
sudo apt update && apt upgrade

## use stow to configure rcfiles
cd ~/dotfiles/
stow rcfiles

sudo apt install -y git sudo zip curl wget ufw vim-nox
sudo apt install -y build-essential stow pwgen htop pass autojump neofetch
sudo apt install -y net-tools dnsutils autossh apt-transport-https
sudo apt install -y ripgrep fzf newsboat figlet

# gui: photo and video
read -p "Install Photo & Video? (N/y) " media
if [ "$media" != "${media#[Yy]}" ]; then
    sudo apt install -y imagemagick pngcrush pandoc gifsicle
    sudo apt install -y rapid-photo-downloader geeqie peek gpick fonts-noto-color-emoji
fi

# gui: fonts
read -p "Install Fonts? (N/y) " fonts
if [ "$fonts" != "${fonts#[Yy]}" ]; then
    mkdir ~/.fonts
    cd ~/.fonts
    unzip $HOME/dotfiles/extras/fonts.zip
    cd
fi

# syncthing
read -p "Install Syncthing? (N/y) " syncthing
if [ "$syncthing" != "${syncthing#[Yy]}" ]; then
	echo "✔ Installing Syncthing"
    if [ ! -f "$HOME/bin/syncthing" ]; then
        cd $HOME/Downloads
        wget https://github.com/syncthing/syncthing/releases/download/v1.2.0/syncthing-linux-amd64-v1.2.0.tar.gz
        tar xfz syncthing-linux-amd64-v1.2.0.tar.gz
        cp syncthing-linux-amd64-v1.2.0/syncthing $HOME/bin/
        #TODO: add to GNOME startup items
        cd
    fi
else
	echo "✖ Skipping Syncthing"
fi

# Node 
sudo apt install -y nodejs yarnpkg

# Golang
sudo apt install -y golang

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

#        _ _
#   __ _(_) |_
#  / _` | | __|
# | (_| | | |_
#  \__, |_|\__|
#  |___/

# install hub
GOPATH=/home/mkaz go get github.com/github/hub

# git-revise
sudo apt-get -y install python3-pip
python3 -m pip install --user git-revise

# Software installs

# sublime text
read -p "Install Sublime Text? (Y/n) " sublime
if [ "$sublime" != "${sublime#[Nn]}" ]; then
	echo "✖ Skipping Sublime Text"
else
	echo "✔ Installing Sublime Text"
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	apt update
	apt install -y sublime-text
fi

# Visual Studio Code

# Slack

# Zoom
