#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
# shellcheck source=./_helpers.sh
source "$DIR/_helpers.sh"

log "Installing fd"
author="sharkdp"
project="fd"
installed_version="$(fd --version || echo "na -1" | cut -d " " -f 2)"
latest_version="$(latest_release_tag_name "$author" "$project")"
fd_version="8.2.1"

if [ "$latest_version" != "$installed_version" ]; then
  echo "Installed: $installed_version"
  echo "Latest: $latest_version"

  cd "$HOME/src" || exit
  fd="fd-musl_${fd_version}_amd64"
  fd_deb="$fd.deb"
  wget "https://github.com/sharkdp/fd/releases/download/v$fd_version/$fd_deb"
  sudo dpkg -i "$fd_deb"
else
  echo "Already on latest: $fd_version"
fi
