#!/bin/bash

set -euxo pipefail

WORKDIR="${WORKDIR:-/tmp/xfce-wayland-build}"

LIBXFCE4WINDOWING_REF="${LIBXFCE4WINDOWING_REF:-master}"
LIBXFCE4UI_REF="${LIBXFCE4UI_REF:-master}"
XFCE4_PANEL_REF="${XFCE4_PANEL_REF:-master}"
XFDESKTOP_REF="${XFDESKTOP_REF:-master}"

#deps
dnf -y builddep libxfce4windowing libxfce4ui xfce4-panel xfdesktop
dnf -y install git meson ninja-build gtk-layer-shell-devel make cmake

cd /tmp

#libxfce4windowing
git clone --depth 1 https://gitlab.xfce.org/xfce/libxfce4windowing.git
cd libxfce4windowing
./autogen.sh
make
make install
cd /tmp

#libxfce4ui
git clone --depth 1 https://gitlab.xfce.org/xfce/libxfce4ui.git
cd libxfce4ui
meson setup build 
meson compile -C build
meson install -C build
cd /tmp

#xfce4-panel
git clone --depth 1 https://gitlab.xfce.org/xfce/xfce4-panel.git
cd xfce4-panel
meson setup build -Dwayland=enabled
meson compile -C build
meson install -C build
cd /tmp

#xfdesktop
git clone --depth 1 https://gitlab.xfce.org/xfce/xfdesktop.git
cd xfce4-panel
meson setup build -Dwayland=enabled
meson compile -C build
meson install -C build

dnf -y install xfce4-appfinder