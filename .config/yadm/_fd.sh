#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
# shellcheck source=./_helpers.sh
source "$DIR/_helpers.sh"

log "Installing fd"
cd "$HOME/src" || exit
export fd_version="8.2.1"
export fd="fd-musl_${fd_version}_amd64"
export fd_deb="$fd.deb"
wget "https://github.com/sharkdp/fd/releases/download/v$fd_version/$fd_deb"
sudo dpkg -i "$fd_deb"
