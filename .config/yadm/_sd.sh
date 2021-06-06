#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
# shellcheck source=./_helpers.sh
source "$DIR/_helpers.sh"

log "Installing sd"
cd "$HOME/src" || exit

author="chmln"
project="sd"
installed_version="$(sd --version || echo "na -1" | cut -d " " -f 2)"
latest_version="$(latest_release_tag_name "$author" "$project")"
sd_version="0.7.6"

if [ "$latest_version" != "$installed_version" ]; then
  echo "Installed: $installed_version"
  echo "Latest: $latest_version"

  sd="sd-v$sd_version-x86_64-unknown-linux-musl"
  wget "https://github.com/$author/$project/releases/download/v$sd_version/$sd"
  sudo mv "$sd" "/usr/local/bin/sd"
else
  echo "Already on latest: $sd_version"
fi
