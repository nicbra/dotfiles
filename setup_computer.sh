#!/bin/bash

set -euo pipefail

dotfiles_path="$(readlink -f "$(dirname "$0")")"
source $dotfiles_path/.common.sh

# Regolith
source /etc/os-release
REGOLITH_VERSION="v3.4" # update this

wget -qO - https://archive.regolith-desktop.com/regolith.key | \
gpg --dearmor | sudo tee /usr/share/keyrings/regolith-archive-keyring.gpg > /dev/null
echo deb "[arch=amd64 signed-by=/usr/share/keyrings/regolith-archive-keyring.gpg] \
https://archive.regolith-desktop.com/ubuntu/stable ${UBUNTU_CODENAME} ${REGOLITH_VERSION}" | \
sudo tee /etc/apt/sources.list.d/regolith.list

# Helix apt repo
sudo add-apt-repository ppa:maveonair/helix-editor

# Wezterm apt repo
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg

# Vivaldi apt repo
wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo apt-key add -
sudo add-apt-repository 'deb https://repo.vivaldi.com/archive/deb/ stable main' -y

# Solaar apt repo. TODO: prompt om vi ønsker å installere dette
sudo add-apt-repository ppa:solaar-unifying/stable

# Apt install
sudo apt update
sudo apt upgrade -y

sudo apt install \
git \
vivaldi-stable \
wezterm \
flameshot \
starship \
helix \
lazygit \
tmux \
solaar

# Install regolith
sudo apt install \
regolith-desktop \
regolith-session-flashback \
regolith-look-lascaille \
xdg-desktop-portal-regolith \
dunst \
libnotify-bin \
wofi

sudo apt purge regolith-rofication

./make_symlinks.sh
