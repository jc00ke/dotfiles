#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
source "$DIR/_helpers.sh"

log "Installing sd"
cd $HOME/src
sd_version="0.7.6"
sd="sd-v$sd_version-x86_64-unknown-linux-musl"
wget "https://github.com/chmln/sd/releases/download/v$sd_version/$sd"
sudo mv "$sd" "/usr/local/bin/sd"
