#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
# shellcheck source=./_helpers.sh
source "$DIR/_helpers.sh"

log "Installing bottom"
cd "$HOME/src" || exit
bottom_version="0.5.6"
bottom="bottom_x86_64-unknown-linux-musl"
wget "https://github.com/ClementTsang/bottom/releases/download/$bottom_version/$bottom.tar.gz"
tar xf "$bottom.tar.gz"
sudo mv "btm" "/usr/local/bin/btm"
