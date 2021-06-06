#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
# shellcheck source=./_helpers.sh
source "$DIR/_helpers.sh"

log "Installing duf"
cd "$HOME/src" || exit
duf_version="0.5.0"
duf="duf_${duf_version}_linux_amd64"
duf_deb="$duf.deb"
wget "https://github.com/muesli/duf/releases/download/v$duf_version/$duf_deb"
sudo dpkg -i "$duf_deb"
