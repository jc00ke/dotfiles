#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
# shellcheck disable=SC1090,SC1091
source "$DIR/_helpers.sh"

log "Installing alacritty"
installed_version="$(alacritty --version | cut -d " " -f 2)"
latest_version="$(latest_release_tag_name "alacritty" "alacritty")"
alacritty_version="0.7.2"

if [ "$latest_version" != "v$installed_version" ]; then
  cd "$HOME/src" || exit 1
  wget "https://github.com/alacritty/alacritty/archive/v$alacritty_version.tar.gz"
  tar xf "v$alacritty_version.tar.gz"
  cd "alacritty-$alacritty_version/" || exit 1
  cargo build --release
  sudo cp target/release/alacritty /usr/local/bin
  sudo mkdir -p /usr/local/share/man/man1
  gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
  sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
  sudo desktop-file-install extra/linux/Alacritty.desktop
  sudo update-desktop-database
  # shellcheck disable=SC2154
  mkdir -p "${fish_complete_path[1]}"
  cp extra/completions/alacritty.fish "${fish_complete_path[1]}/alacritty.fish"
  sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/alacritty 50
  sudo update-alternatives --config x-terminal-emulator
  # to remove
  # sudo update-alternatives --remove "x-terminal-emulator" "/usr/local/bin/alacritty"

  pip3 install alacritty-colorscheme asciinema
else
  echo "Already on latest: $alacritty_version"
fi
