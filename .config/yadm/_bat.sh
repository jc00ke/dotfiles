#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
# shellcheck source=./_helpers.sh
source "$DIR/_helpers.sh"

log "Installing bat"
installed_version="$(bat --version | cut -d " " -f 2)"
latest_version="$(latest_release_tag_name "sharkdp" "bat")"
bat_version="0.17.1"

if [ "$latest_version" != "v$installed_version" ]; then
  echo "Installed: $installed_version"
  echo "Latest: $latest_version"

  cd "$HOME/src" || exit 1
  bat="bat_${bat_version}_amd64"
  bat_deb="$bat.deb"
  wget "https://github.com/sharkdp/bat/releases/download/v$bat_version/$bat_deb"
  sudo dpkg -i "$bat_deb"
else
  echo "Already on latest: $bat_version"
fi
