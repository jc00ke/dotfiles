#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
# shellcheck source=./_helpers.sh
source "$DIR/_helpers.sh"

log "Installing direnv"
author="direnv"
project="direnv"
installed_version="$(direnv version)"
latest_version="$(latest_release_tag_name "$author" "$project")"
direnv_version="2.28.0"

if [ "$latest_version" != "v$direnv_version" ]; then
  echo "BUMP from v$direnv_version to $latest_version"
  exit 0
fi

if [ "$latest_version" != "v$installed_version" ]; then
  echo "Installed: $installed_version"
  echo "Latest: $latest_version"

  cd "$HOME/src" || exit 1
  direnv="direnv.linux-amd64"
  wget "https://github.com/$author/$project/releases/download/v$direnv_version/$direnv"
  chmod +x "$direnv"
  mv "$direnv" "$HOME/.local/bin/direnv"
else
  echo "Already on latest: $direnv_version"
fi
