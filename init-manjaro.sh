#!/bin/bash

# Install script for setting up Manjaro

cd $HOME

rm -f .bashrc
ln -s dotfiles/profile .bashrc
ln -s ~/Documents/Sync/pass-store .password-store

mkdir ~/bin/
mkdir ~/src/
mkdir ~/tmp/
mkdir ~/Downloads/

## update & upgrade
sudo pacman -Syu --needed --noconfirm base-devel stow pwgen htop pass neofetch autossh
sudo pacman -Syu --needed --noconfirm bat exa fd flameshot fzf jq ripgrep yay julia
sudo pacman -Syu --needed --noconfirm powerline-fonts ttf-roboto

# gnome extensions
gnome-extensions install gTile@vibou
gnome-extensions install ProxySwitcher@flannaghan.com


## use stow to configure rcfiles
# works better after its installed
cd ~/dotfiles/
stow rcfiles

# Image and Media
sudo pacman -Syu --needed --noconfirm imagemagick pngcrush pandoc gifsicle peek gpick

# Neovim
sudo pacman -Syu --needed --noconfirm neovim neovim-qt
mkdir -p $HOME/.config
cd $HOME/.config
ln -s $HOME/dotfiles/extras/nvim

# Syncthing
sudo pacman -Syu --needed --noconfirm syncthing

# Install Node via nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
nvm install --lts

# LAMP (use Local?)
read -p "Install LAMP Stack? (Y/n) " lamp
if [ "$lamp" != "${lamp#[Nn]}" ]; then
	echo "✖ Skipping LAMP"
else
	echo "✔ Installing LAMP"
    sudo pacman -Syu --needed --noconfirm apache
    sudo pacman -Syu --needed --noconfirm php php-gd php-imagick php-intl php-apache
    sudo pacman -Syu --needed --noconfirm mariadb
	# create initial db
	sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
	sudo systemctl enable httpd
	sudo systemctl enable mysql
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

# Software installs

# sublime text
read -p "Install Sublime Text? (Y/n) " sublime
if [ "$sublime" != "${sublime#[Nn]}" ]; then
	echo "✖ Skipping Sublime Text"
else
	echo "✔ Installing Sublime Text"
	curl -O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key --add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg
	echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/stable/x86_64" | sudo tee -a /etc/pacman.conf
	sudo pacman -Syu --needed --noconfirm sublime-text
fi

cd $HOME/Downloads

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y

# espanso
sudo pacman -Syu --needed --confirm xdotool xclip libnotify
curl -L https://github.com/federico-terzi/espanso/releases/latest/download/espanso-linux.tar.gz | tar -xz -C $HOME/tmp/
mv $HOME/tmp/espanso $HOME/bin/
mkdir ~/.config/espanso
ln -s ~/dotfiles/extras/espanso-default.yml ~/.config/espanso/default.yml

# autojump
cd $HOME/tmp
git clone git://github.com/wting/autojump.git
cd autojump
./install.py
