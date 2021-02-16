#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
source "$DIR/_helpers.sh"

log "Installing bat"
cd $HOME/src
bat_version="0.17.1"
bat="bat_${bat_version}_amd64"
bat_deb="$bat.deb"
wget "https://github.com/sharkdp/bat/releases/download/v$bat_version/$bat_deb"
sudo dpkg -i "$bat_deb"
