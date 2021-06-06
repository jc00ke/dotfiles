#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
# shellcheck source=./_helpers.sh
source "$DIR/_helpers.sh"

log "Installing zoxide"
author="ajeetdsouza"
project="zoxide"
installed_version="$(zoxide -V || echo "na -1" | cut -d " " -f 2)"
latest_version="$(latest_release_tag_name "$author" "$project")"
zoxide_version="0.7.0"

if [ "$latest_version" != "$installed_version" ]; then
  echo "Installed: $installed_version"
  echo "Latest: $latest_version"

  cd "$HOME/src" || exit 1
  zoxide="zoxide-x86_64-unknown-linux-musl"
  wget "https://github.com/$author/$project/releases/download/v$zoxide_version/$zoxide.tar.gz"
  tar xf "$zoxide.tar.gz"
  sudo mv "$zoxide/zoxide" "/usr/local/bin/zoxide"
  sudo chmod +x "/usr/local/bin/zoxide"
  sudo cp "$zoxide/man/* /usr/local/share/man/man1/"
else
  echo "Already on latest: $zoxide_version"
fi
