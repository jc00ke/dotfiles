#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
# shellcheck source=./_helpers.sh
source "$DIR/_helpers.sh"

log "Installing gping"
author="orf"
project="gping"
installed_version="$(gping --version || echo "na -1" | cut -d " " -f 2)"
latest_version="$(latest_release_tag_name "$author" "$project")"
gping_version="v1.2.0-post"

if [ "$latest_version" != "$installed_version" ]; then
  echo "Installed: $installed_version"
  echo "Latest: $latest_version"

  cd "$HOME/src" || exit 1

  gping="gping-x86_64-unknown-linux-musl.tar.gz"
  wget "https://github.com/$author/$project/releases/download/$gping_version/$gping"
  tar xf "$gping"
  sudo mv "gping" "/usr/local/bin/gping"
else
  echo "Already on latest: $gping_version"
fi
