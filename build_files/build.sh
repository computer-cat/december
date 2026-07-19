#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

dnf install -y dnf5-plugins

#wm
dnf copr enable -y yalter/niri
dnf install -y niri --setopt=install_weak_deps=False


#misc utils
dnf install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
dnf install -y tailscale zoxide fastfetch xfce4-terminal \
    qt6ct matugen foot swaylock \
    xdg-desktop-portal-gtk xdg-desktop-portal-gnome \
    gnome-keyring fuzzel micro tuigreet polkit-kde \
    pavucontrol chezmoi

#gamerslop
dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
dnf install -y steam mangohud gamescope