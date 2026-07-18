#!/bin/bash

#xfce wayland session installer

set -euxo pipefail

mkdir -p /var/roothome

#deps
dnf -y builddep libxfce4windowing libxfce4ui xfce4-panel xfdesktop xfconf
dnf -y install git meson ninja-build gtk-layer-shell-devel make cmake \
  gstreamer1 gstreamer1-devel gstreamer1-plugins-base-devel \
  gstreamer1-plugins-good-gtk \
  rust cargo \
  gettext libdisplay-info-devel libdrm-devel mesa-libgbm-devel \
  gtk3-devel libinput-devel pixman-devel libseat-devel \
  systemd-devel libxfce4ui-devel xfconf-devel libxkbcommon-devel \
  xorg-x11-server-Xwayland

cd /tmp

#libxfce4windowing
git clone --depth 1 https://gitlab.xfce.org/xfce/libxfce4windowing.git
cd libxfce4windowing
git submodule update --init --recursive --depth 1
meson setup build --prefix=/usr
meson compile -C build
meson install -C build
cd /tmp

#libxfce4ui
git clone --depth 1 https://gitlab.xfce.org/xfce/libxfce4ui.git
cd libxfce4ui
git submodule update --init --recursive --depth 1
meson setup build --prefix=/usr
meson compile -C build
meson install -C build
cd /tmp

#xfce4-panel
git clone --depth 1 https://gitlab.xfce.org/xfce/xfce4-panel.git
cd xfce4-panel
meson setup build --prefix=/usr -Dwayland=enabled -Dgtk-layer-shell=enabled
meson compile -C build
meson install -C build
cd /tmp

#xfdesktop
git clone --depth 1 https://gitlab.xfce.org/xfce/xfdesktop.git
cd xfdesktop
git submodule update --init --recursive --depth 1
meson setup build --prefix=/usr -Dwayland=enabled
meson compile -C build
meson install -C build
cd /tmp

#xfconf
git clone --depth 1 https://gitlab.xfce.org/xfce/xfconf.git
cd xfconf
git submodule update --init --recursive --depth 1
meson setup build
meson compile -C build
meson install -C build
cd /tmp

#xfce4-settings
git clone --depth 1 https://gitlab.xfce.org/xfce/xfce4-settings.git
cd xfce4-settings
git submodule update --init --recursive --depth 1
meson setup build
meson compile -C build
meson install -C build
cd /tmp

#xfwl4
git clone --depth 1 https://gitlab.xfce.org/xfce/xfwl4.git
cd xfwl4
git submodule update --init --recursive --depth 1
meson setup --wipe build
meson compile -C build
meson install -C build
cd /tmp


#extras
dnf -y install thunar-archive-plugin xfce4-pulseaudio-plugin
