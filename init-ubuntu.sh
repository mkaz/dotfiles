#!/bin/bash

# install script for setting up linux
# typicall an ubuntu / gnome distro

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

sudo apt-get -y install build-essential automake autoconf gnu-standards libtool gettext ctags
sudo apt-get -y install curl wget pwgen net-tools dnsutils htop ufw pass autojump neofetch autossh
sudo apt-get -y install imagemagick pngcrush pandoc gifsicle units figlet ruby-dev
sudo apt-get -y install ripgrep fzf

# gui: gnome stuff
sudo apt-get -y install vim-gtk3 xclip gpick chrome-gnome-shell gnome-shell-extensions gconf2 gnome-tweaks

# click to dock icon to minimize
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'

# gui: photo and video
sudo apt-get -y install rapid-photo-downloader geeqie newsboat kazam vokoscreen screenkey

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
    sudo cp syncthing-linux-amd64-v1.2.0/syncthing /usr/bin/
    sudo cp syncthing-linux-amd64-v1.2.0/etc/linux-systemd/system/syncthing@.service /etc/systemd/system
    sudo systemctl enable syncthing@mkaz.service
    sudo systemctl start syncthing@mkaz.service
    cd
fi


#  ___ _ __   __ _ _ __  ___
# / __| '_ \ / _` | '_ \/ __|
# \__ \ | | | (_| | |_) \__ \
# |___/_| |_|\__,_| .__/|___/
#                 |_|
sudo snap install slack --classic

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

# sublime text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get -y install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get -y update
sudo apt-get -y install sublime-text

