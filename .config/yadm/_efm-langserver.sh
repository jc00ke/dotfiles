#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
# shellcheck disable=SC1090,SC1091
source "$DIR/_helpers.sh"

log "Installing efm-langserver"
author="mattn"
project="efm-langserver"
installed_version="$(efm-langserver -v | cut -d " " -f 2)"
latest_version="$(latest_release_tag_name "$author" "$project")"
efm_version="0.0.30"

if [ "$latest_version" != "v$installed_version" ]; then
  echo "Installed: $installed_version"
  echo "Latest: $latest_version"

  cd "$HOME/src" || exit 1
  efm="efm-langserver_v${efm_version}_linux_amd64"
  efm_tarball="$efm.tar.gz"
  wget "https://github.com/$author/$project/releases/download/v$efm_version/$efm_tarball"
  tar xf "$efm_tarball"
  cp -f "$efm/efm-langserver" ~/.local/bin/
else
  echo "Already on latest: $efm_version"
fi
