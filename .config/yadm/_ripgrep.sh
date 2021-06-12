#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d $DIR ]]; then DIR="$PWD"; fi
# shellcheck source=./_helpers.sh
source "$DIR/_helpers.sh"

log "Installing ripgrep"
author="BurntSushi"
project="ripgrep"
installed_version="$(rg --version | cut -d " " -f2 | head -n 1)"
latest_version="$(latest_release_tag_name "$author" "$project")"
ripgrep_version="13.0.0"

if [ "$latest_version" != "$installed_version" ]; then
	echo "Installed: $installed_version"
	echo "Latest: $latest_version"

	cd "$HOME/src" || exit
	ripgrep="ripgrep_${ripgrep_version}_amd64"
	ripgrep_deb="$ripgrep.deb"
	wget "https://github.com/$author/$project/releases/download/$ripgrep_version/$ripgrep_deb"
	sudo dpkg -i "$ripgrep_deb"
else
	echo "Already on latest: $ripgrep_version"
fi
