#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
source "$DIR/_helpers.sh"

log "Installing zoxide"
cd $HOME/src
zoxide_version="0.5.0"
zoxide="zoxide-x86_64-unknown-linux-musl"
wget "https://github.com/ajeetdsouza/zoxide/releases/download/v$zoxide_version/$zoxide"
sudo mv "$zoxide" "/usr/local/bin/zoxide"
sudo chmod +x "/usr/local/bin/zoxide"
