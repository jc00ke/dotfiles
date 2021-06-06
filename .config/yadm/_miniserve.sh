#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
# shellcheck source=./_helpers.sh
source "$DIR/_helpers.sh"

log "Installing miniserve"
cd "$HOME/src" || exit
miniserve_version="0.10.3"
miniserve="miniserve-v$miniserve_version-linux-x86_64"
wget "https://github.com/svenstaro/miniserve/releases/download/v$miniserve_version/$miniserve"
chmod +x "$miniserve"
sudo mv "$miniserve" "/usr/local/bin/miniserve"
