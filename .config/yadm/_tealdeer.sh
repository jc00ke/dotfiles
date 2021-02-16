#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
source "$DIR/_helpers.sh"

log "Installing tealdeer"
cd $HOME/src
tealdeer_version="1.4.1"
tealdeer="tldr-linux-x86_64-musl"
wget "https://github.com/dbrgn/tealdeer/releases/download/v$tealdeer_version/$tealdeer"
sudo mv "$tealdeer" "/usr/local/bin/tldr"
