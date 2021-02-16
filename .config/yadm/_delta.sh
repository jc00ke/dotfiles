#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
source "$DIR/_helpers.sh"

log "Installing delta"
cd $HOME/src
delta_version="0.4.4"
delta="git-delta-musl_${delta_version}_amd64"
delta_deb="$delta.deb"
wget "https://github.com/dandavison/delta/releases/download/$delta_version/$delta_deb"
sudo dpkg -i "$delta_deb"
