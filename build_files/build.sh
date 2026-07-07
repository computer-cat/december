#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /
dnf install -y dnf5-plugins

#essentials
dnf install -y git distrobox flatpak

#wm
dnf copr enable -y yalter/niri
dnf install -y niri --setopt=install_weak_deps=False
dnf install -y xdg-desktop-portal-gtk xdg-desktop-portal-gnome gnome-keyring

#shell
dnf copr enable -y lionheartp/Hyprland
dnf install -y noctalia-git noctalia-greeter

#misc utils
dnf install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
dnf install -y tailscale zoxide fastfetch foot micro nautilus bash-completions

#gamerslop
dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
dnf install -y steam mangohud gamescope

systemctl enable podman.socket
