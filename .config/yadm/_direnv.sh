#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
# shellcheck disable=SC1090,SC1091
source "$DIR/_helpers.sh"

log "Installing direnv"
installed_version="$(direnv version)"
latest_version="$(latest_release_tag_name "direnv" "direnv")"
direnv_version="2.28.0"

if [ "$latest_version" != "v$installed_version" ]; then
  echo "Installed: $installed_version"
  echo "Latest: $latest_version"

  cd "$HOME/src" || exit 1
  direnv="direnv.linux-amd64"
  wget "https://github.com/direnv/direnv/releases/download/v$direnv_version/$direnv"
  chmod +x "$direnv"
  mv "$direnv" "$HOME/.local/bin/direnv"
else
  echo "Already on latest: $direnv_version"
fi
