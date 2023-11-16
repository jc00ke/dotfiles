#!/bin/bash

DIR="${BASH_SOURCE%/*}" || if [[ ! -d $DIR ]]; then DIR="$PWD"; fi
source "$DIR/_heroku.sh"
source "$DIR/_sd.sh"
source "$DIR/_swappy.sh"
source "$DIR/_tealdeer.sh"
source "$DIR/_beekeeper.sh"
