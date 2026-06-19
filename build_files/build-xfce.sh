#!/bin/bash

set -euxo pipefail

#deps
dnf -y builddep libxfce4windowing libxfce4ui xfce4-panel xfdesktop
dnf -y install git meson ninja-build gtk-layer-shell-devel make cmake \
    gstreamer1 gstreamer1-devel gstreamer1-plugins-base-devel \
    gstreamer1-plugins-good-gtk

cd /tmp

#libxfce4windowing
git clone --depth 1 https://gitlab.xfce.org/xfce/libxfce4windowing.git
cd libxfce4windowing
./autogen.sh --prefix=/usr
make
make install
cd /tmp

#libxfce4ui
git clone --depth 1 https://gitlab.xfce.org/xfce/libxfce4ui.git
cd libxfce4ui
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
meson setup build --prefix=/usr -Dwayland=enabled
meson compile -C build
meson install -C build

#xfce4-settings
dnf -y install xfce4-settings thunar-archive-plugin