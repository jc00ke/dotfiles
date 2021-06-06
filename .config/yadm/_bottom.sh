#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
# shellcheck source=./_helpers.sh
source "$DIR/_helpers.sh"

log "Installing bottom"
author="ClementTsang"
project="bottom"
installed_version="$(btm --version || echo "na -1" | cut -d " " -f 2)"
latest_version="$(latest_release_tag_name "$author" "$project")"
bottom_version="0.6.1"

if [ "$latest_version" != "$installed_version" ]; then
  echo "Installed: $installed_version"
  echo "Latest: $latest_version"

  cd "$HOME/src" || exit
  bottom="bottom_x86_64-unknown-linux-musl"
  wget "https://github.com/$author/$project/releases/download/$bottom_version/$bottom.tar.gz"
  tar xf "$bottom.tar.gz"
  sudo mv "btm" "/usr/local/bin/btm"
else
  echo "Already on latest: $bottom_version"
fi
