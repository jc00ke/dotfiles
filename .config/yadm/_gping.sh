#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
# shellcheck source=./_helpers.sh
source "$DIR/_helpers.sh"

log "Installing gping"
cd "$HOME/src" || exit
gping_version="v1.2.0-post"
gping="gping-x86_64-unknown-linux-musl.tar.gz"
wget "https://github.com/orf/gping/releases/download/$gping_version/$gping"
tar xf "$gping"
sudo mv "gping" "/usr/local/bin/gping"
