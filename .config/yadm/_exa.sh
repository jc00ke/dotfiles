#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
# shellcheck source=./_helpers.sh
source "$DIR/_helpers.sh"

log "Installing exa"
author="ogham"
project="exa"
installed_version="$(exa -v || echo "na -1" | cut -d " " -f 2)"
latest_version="$(latest_release_tag_name "$author" "$project")"
exa_version="0.9.0"

if [ "$latest_version" != "$installed_version" ]; then
  cd "$HOME/src" || exit
  exa="exa-linux-x86_64"
  exa_zip="$exa-$exa_version.zip"
  wget "https://github.com/$author/$project/releases/download/v$exa_version/$exa_zip"
  unzip "$exa_zip"
  sudo mv "$exa" "/usr/local/bin/exa"
else
  echo "Already on latest: $exa_version"
fi
