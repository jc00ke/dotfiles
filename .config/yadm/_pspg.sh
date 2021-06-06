#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
# shellcheck source=./_helpers.sh
source "$DIR/_helpers.sh"

log "Installing pspg"
set -x
installed_version="$(pspg --version | head -n 1 | cut -d "-" -f 2)"
latest_version="$(latest_release_tag_name "okbob" "pspg")"
pspg_version="4.3.0"

if [ "$latest_version" != "$installed_version" ]; then
  echo "Installed: $installed_version"
  echo "Latest: $latest_version"

  cd "$HOME/src" || exit 1
  wget "https://github.com/okbob/pspg/archive/$pspg_version.tar.gz"
  tar xf "$pspg_version.tar.gz"
  cd "pspg-$pspg_version" || exit
  ./configure
  make && sudo make install
else
  echo "Already on latest: $pspg_version"
fi
