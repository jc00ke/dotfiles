#!/bin/bash

set -ox pipefail

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
# shellcheck source=./_helpers.sh
source "$DIR/_helpers.sh"

log "Installing tealdeer"
author="dbrgn"
project="tealdeer"
installed_version="$(tealdeer --version || echo "na -1" | cut -d " " -f 2)"
latest_version="$(latest_release_tag_name "$author" "$project")"
tealdeer_version="1.6.1"


if [ "$latest_version" != "$installed_version" ]; then
  echo "Installed: $installed_version"
  echo "Latest: $latest_version"

  cd "$HOME/src" || exit
  tealdeer="tealdeer-linux-x86_64-musl"
  wget "https://github.com/dbrgn/tealdeer/releases/download/v$tealdeer_version/$tealdeer"
  chmod +x "$tealdeer"
  sudo mv "$tealdeer" "/usr/local/bin/tldr"
else
  echo "Already on latest: $tealdeer_version"
fi
