#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

#wm
dnf copr enable -y yalter/niri
dnf install -y niri --setopt=install_weak_deps=False


#misc utils
dnf install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
dnf install -y tailscale zoxide fastfetch xfce4-terminal \
    qt6ct swaybg matugen foot swaylock \
    xdg-desktop-portal-gtk xdg-desktop-portal-gnome \
    gnome-keyring fuzzel micro awww

#gamerslop
dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
dnf install -y steam mangohud gamescope

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
