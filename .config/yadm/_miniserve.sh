#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
# shellcheck source=./_helpers.sh
source "$DIR/_helpers.sh"

log "Installing miniserve"
author="svenstaro"
project="miniserve"
installed_version="$(miniserve --version || echo "na -1" | cut -d " " -f 2)"
latest_version="$(latest_release_tag_name "$author" "$project")"
miniserve_version="0.10.3"

if [ "$latest_version" != "$installed_version" ]; then
  echo "Installed: $installed_version"
  echo "Latest: $latest_version"

  cd "$HOME/src" || exit
  miniserve="miniserve-v$miniserve_version-linux-x86_64"
  wget "https://github.com/$author/$project/releases/download/v$miniserve_version/$miniserve"
  chmod +x "$miniserve"
  sudo mv "$miniserve" "/usr/local/bin/miniserve"
else
  echo "Already on latest: $miniserve_version"
fi
