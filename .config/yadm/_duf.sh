#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
# shellcheck source=./_helpers.sh
source "$DIR/_helpers.sh"

log "Installing duf"
author="muesli"
project="duf"
installed_version="$(duf -version|| echo "na -1" | cut -d " " -f 2)"
latest_version="$(latest_release_tag_name "$author" "$project")"
program_version="0.6.2"

if [ "$latest_version" != "v$program_version" ]; then
  echo "BUMP from $program_version to $latest_version"
  exit 0
fi

if [ "$latest_version" != "$installed_version" ]; then
  cd "$HOME/src" || exit
  duf="duf_${program_version}_linux_amd64"
  duf_deb="$duf.deb"
  wget "https://github.com/$author/$project/releases/download/v$program_version/$duf_deb"
  sudo dpkg -i "$duf_deb"
else
  echo "Already on latest: $program_version"
fi
