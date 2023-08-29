#!/bin/env bash
# https://github.com/jtheoof/swappy

sudo apt install \
	scdoc \
	gettext \
	meson \
	ninja-build \
	wl-clipboard \
	grim \
	slurp \
	pkg-config \
	libcairo2-dev \
	libgtk-3-dev \
	libpango1.0-dev \
	libgtk-3-0 \
	libglib2.0-0 \
	git
	# otf-font-awesome

cd $HOME/src
git clone git@github.com:jtheoof/swappy.git
meson setup build
ninja -C build
sudo cp -f build/swappy /usr/local/bin/
