# shellcheck shell=sh

log() {
  msg="$1"
  echo "********************************************"
  echo "$msg"
  echo "********************************************"
  echo ""
}

latest_release_tag_name() {
  owner=$1
  repo=$2
  version="$(curl \
    -s \
    -L \
    -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/repos/$owner/$repo/releases/latest" \
    | jq --raw-output .tag_name)"
  echo "$version"
}
