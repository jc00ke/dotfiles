#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
source "$DIR/_helpers.sh"

log "Installing starship"
cd $HOME/src
curl -fsSL "https://starship.rs/install.sh" | bash
