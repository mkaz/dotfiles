#!/bin/bash

# Install script for setting up my Ubuntu

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
sudo apt update && sudo apt upgrade -y

## use stow to configure rcfiles
cd ~/dotfiles/

sudo apt install -y git subversion sudo zip curl wget ufw vim-nox
sudo apt install -y build-essential stow pwgen htop pass autojump neofetch
sudo apt install -y net-tools dnsutils autossh apt-transport-https
sudo apt install -y fzf jq newsboat figlet gnome-tweaks gnome-shell-pomodoro gnome-dictionary flameshot


# works better after its installed
stow rcfiles

# gui: photo and video
read -p "Install Photo & Video? (N/y) " media
if [ "$media" != "${media#[Yy]}" ]; then
    sudo apt install -y imagemagick pngcrush pandoc gifsicle obs-studio
    sudo apt install -y rapid-photo-downloader geeqie peek gpick fonts-noto-color-emoji
fi

# gui: fonts
read -p "Install Fonts? (N/y) " fonts
if [ "$fonts" != "${fonts#[Yy]}" ]; then
	sudo apt install -y fonts-hack fonts-ibm-plex fonts-noto fonts-roboto ttf-mscorefonts-installer
fi

#----------------------------------------
# Neovim
#----------------------------------------
cd $HOME/Downloads
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
mv ./nvim.appimage $HOME/bin/nvim

# symlink config
mkdir -p $HOME/.config
cd $HOME/.config
ln -s $HOME/dotfiles/extras/nvim
#----------------------------------------


#----------------------------------------
# Syncthing
#----------------------------------------
read -p "Install Syncthing? (N/y) " syncthing
if [ "$syncthing" != "${syncthing#[Yy]}" ]; then
	echo "✔ Installing Syncthing"
    if [ ! -f "$HOME/bin/syncthing" ]; then
        cd $HOME/Downloads
        wget https://github.com/syncthing/syncthing/releases/download/v1.8.0/syncthing-linux-amd64-v1.8.0.tar.gz
        tar xfz syncthing-linux-amd64-v1.8.0.tar.gz
        cp syncthing-linux-amd64-v1.8.0/syncthing $HOME/bin/
        #TODO: add to GNOME startup items
        cd
    fi
else
	echo "✖ Skipping Syncthing"
fi
#----------------------------------------

# Install Node via nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash
nvm install --lts


# LAMP (use Local?)
read -p "Install LAMP Stack? (Y/n) " lamp
if [ "$lamp" != "${lamp#[Nn]}" ]; then
	echo "✖ Skipping LAMP"
else
	echo "✔ Installing LAMP"
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

# disable printer auto discovery
# easier to configure and setup manually
sudo systemctl stop cups-browsed
sudo systemctl disable cups-browsed

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

cd $HOME/Downloads

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y

## install fd
wget https://github.com/sharkdp/fd/releases/download/v8.2.1/fd_8.2.1_amd64.deb
sudo apt install -y ./fd_8.2.1_amd64.deb

# Add bat and ripgrep
# Necessary for 20.04 - can be simplified to normal bat/ripgrep on upgrade
sudo apt install -o Dpkg::Options::="--force-overwrite" bat ripgrep

# espanso
wget https://github.com/federico-terzi/espanso/releases/latest/download/espanso-debian-amd64.deb
sudo apt install -y ./espanso-debian-amd64.deb

# use latest git
sudo add-apt-repository -y ppa:git-core/ppa
sudo apt install -y git
