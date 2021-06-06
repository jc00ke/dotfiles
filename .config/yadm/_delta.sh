#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
# shellcheck source=./_helpers.sh
source "$DIR/_helpers.sh"

log "Installing delta"
installed_version="$(delta --version | cut -d " " -f 2)"
latest_version="$(latest_release_tag_name "dandavison" "delta")"
delta_version="0.8.0"

if [ "$latest_version" != "v$installed_version" ]; then
  echo "Installed: $installed_version"
  echo "Latest: $latest_version"

  cd "$HOME/src" || exit 1
  delta="git-delta-musl_${delta_version}_amd64"
  delta_deb="$delta.deb"
  wget "https://github.com/dandavison/delta/releases/download/$delta_version/$delta_deb"
  sudo dpkg -i "$delta_deb"
else
  echo "Already on latest: $delta_version"
fi
