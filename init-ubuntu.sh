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

sudo apt install -y git subversion sudo zip curl wget ufw neovim neovim-qt
sudo apt install -y build-essential stow pwgen htop pass autojump neofetch
sudo apt install -y net-tools dnsutils autossh apt-transport-https syncthing
sudo apt install -y fzf jq figlet gnome-tweaks gnome-shell-pomodoro gnome-dictionary flameshot


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

# symlink config
mkdir -p $HOME/.config
cd $HOME/.config
ln -s $HOME/dotfiles/extras/nvim
#----------------------------------------


# Install Node using volta
curl https://get.volta.sh | bash

# enable and start syncthing
sudo systemctl enable syncthing@mkaz.service
sudo systemctl start syncthing@mkaz.service

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


cd $HOME/Downloads

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y

## install fd
wget https://github.com/sharkdp/fd/releases/download/v8.2.1/fd_8.2.1_amd64.deb
sudo apt install -y ./fd_8.2.1_amd64.deb

# Add bat and ripgrep
# Necessary for 20.04 - can be simplified to normal bat/ripgrep on upgrade
#sudo apt install -o Dpkg::Options::="--force-overwrite" bat ripgrep

## install exa
wget https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip
unzip exa-linux-x86_64-0.9.0.zip
mv exa-linux-x86_64 ~/bin/exa

# espanso
wget https://github.com/federico-terzi/espanso/releases/latest/download/espanso-debian-amd64.deb
sudo apt install -y ./espanso-debian-amd64.deb

# Obsidian
wget https://github.com/obsidianmd/obsidian-releases/releases/download/v0.12.12/Obsidian-0.12.12.AppImage
mv Obsidian-0.12.12.AppImage $HOME/bin/Obsidian.desktop
curl -L -o obsidian.png https://cdn.discordapp.com/icons/686053708261228577/1361e62fed2fee55c7885103c864e2a8.png
sudo cp obsidian.png /usr/share/pixmaps/
cat << _EOL > $HOME/.local/share/applications/Obsidian.desktop
[Desktop Entry]
Name=Obsidian
Comment=Markdown Notetaking App
Terminal=false
GenericName=Text Editor
Type=Application
Exec=/home/matthias/AppImages/Obsidian-0.10.11.AppImage %u
Icon=obsidian
StartupWMClass=obsidian
MimeType=x-scheme-handler/obsidian;
_EOL

# Signal
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
	  sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
sudo apt update && sudo apt install signal-desktop
