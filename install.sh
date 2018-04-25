#!/bin/bash

set -e

sudo pacman -S networkmanager network-manager-applet gnome-keyring iw wpa_supplicant dialog wpa_actiond ifplugd
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager
sudo systemctl stop dhcpcd
sudo pacman -R dhcpcd

sudo pacman -S git vim curl wget terminator tmux zsh guake htop iotop
sudo pacman -S i3 dmenu xorg xorg-xinit xf86-video-intel xorg-xbacklight xf86-input-synaptics xautolock
sudo pacman -S firefox ranger vlc lxappearance arandr ntfs-3g noto-fonts
sudo pacman -S alsa-firmware alsa-utils alsa-plugins pulseaudio-alsa pulseaudio pavucontrol playerctl
sudo pacman -S thunar feh compton tumbler arc-gtk-theme arc-icon-theme zathura imagemagick
sudo pacman -S unzip mlocate wget curl gparted strace
sudo pacman -S bluez bluez-libs bluez-utils pulseaudio-bluetooth blueman
sudo pacman -S base-devel
sudo pacman -S acpid acpi

sudo systemctl enable acpid

mkdir "$HOME/AUR";
git clone "https://aur.archlinux.org/aurman.git";
cd "$HOME/AUR/aurman";
makepkg -Acs;
sudo pacman -U aurman*.tar.xz;
cd -;

aurman -S glipper escrotum-git polybar-git;
aurman -S sublime-text-dev && sudo ln -s /usr/bin/subl3 /usr/bin/subl;

sudo usermod -aG lp "$USER";

sudo ln -s /etc/fonts/conf.avail/{70-no-bitmaps.conf,10-sub-pixel-rgb.conf,11-lcdfilter-default.conf,66-noto-mono.conf,66-noto-sans.conf,66-noto-serif.conf} /etc/fonts/conf.d/

sudo cp synaptics.conf /etc/X11/xorg.conf.d/70-synaptics.conf;
sudo cp logind.conf /etc/systemd/;
cp xinitrc "$HOME/.xinitrc";
cp Xdefaults "$HOME/.Xdefaults";
cp zshrc "$HOME/.zshrc";
cp gitconfig "$HOME/.gitconfig";
mkdir -p "$HOME/.config" && cp -r config/* "$HOME/.config/";
mkdir -p "$HOME/.vim" && cp -r vim/* "$HOME/.vim/";
mkdir -p "$HOME/.local/share/fonts/" && cp -r fonts/* "$HOME/.local/share/fonts/";
cat profile | sudo tee -a /etc/profile > /dev/null;
touch $HOME/.Xauthority;

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)";
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.9/install.sh | bash;

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm install --lts && npm install -g gtop;
dconf load / < dconf/*;

"$HOME/.config/wallpaper.sh";