#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
source "$DIR/_helpers.sh"

log "Installing ripgrep"
cd $HOME/src
ripgrep_version="12.1.1"
ripgrep="ripgrep_${ripgrep_version}_amd64"
ripgrep_deb="$ripgrep.deb"
wget "https://github.com/BurntSushi/ripgrep/releases/download/$ripgrep_version/$ripgrep_deb"
sudo dpkg -i "$ripgrep_deb"
