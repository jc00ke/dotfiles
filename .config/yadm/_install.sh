#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
# shellcheck source=./_alacritty.sh
source "$DIR/_alacritty.sh"
source "$DIR/_bottom.sh"
source "$DIR/_delta.sh"
source "$DIR/_direnv.sh"
source "$DIR/_duf.sh"
source "$DIR/_efm-langserver.sh"
source "$DIR/_exa.sh"
source "$DIR/_fd.sh"
source "$DIR/_gping.sh"
source "$DIR/_miniserve.sh"
source "$DIR/_pspg.sh"
source "$DIR/_sd.sh"
source "$DIR/_starship.sh"
source "$DIR/_tealdeer.sh"
source "$DIR/_zoxide.sh"
