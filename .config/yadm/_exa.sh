#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
source "$DIR/_helpers.sh"

log "Installing exa"
cd $HOME/src
exa_version="0.9.0"
exa="exa-linux-x86_64"
exa_zip="$exa-$exa_version.zip"
wget "https://github.com/ogham/exa/releases/download/v$exa_version/$exa_zip"
unzip "$exa_zip"
sudo mv "$exa" "/usr/local/bin/exa"
