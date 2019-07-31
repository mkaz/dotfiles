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
sudo apt-get -y install git sudo zip stow

## use stow to configure rcfiles
cd ~/dotfiles/
stow rcfiles

#  _               _
# | |__   __ _ ___(_) ___ ___
# | '_ \ / _` / __| |/ __/ __|
# | |_) | (_| \__ \ | (__\__ \
# |_.__/ \__,_|___/_|\___|___/

sudo apt-get -y install build-essential automake autoconf gnu-standards libtool gettext ctags curl wget pwgen net-tools dnsutils htop ufw pass autojump taskwarrior neofetch imagemagick pngcrush pandoc units figlet ruby-dev ripgrep fzf neovim autossh 

#   ____ _   _ ___
#  / ___| | | |_ _|
# | |  _| | | || |
# | |_| | |_| || |
#  \____|\___/|___|

sudo apt-get -y install xclip gpick chrome-gnome-shell screenkey rapid-photo-downloader geeqie newsboat gconf2 gnome-shell-extensions gnoe-tweaks
mkdir ~/.fonts
cd ~/.fonts
unzip $HOME/dotfiles/extras/fonts.zip
cd

# install Peek gif
sudo add-apt-repository -y ppa:peek-developers/stable
sudo apt-get -y install peek

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
sudo apt-get -y install php php-cli php-common php-curl php-dev php-memcached php-mysql php-json php-mbstring php-intl php-xml
sudo apt-get -y install apache2 libapache2-mod-php
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

# sublime text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get -y install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get -y update
sudo apt-get -y install sublime-text

