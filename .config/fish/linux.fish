# linux
# @fish-lsp-disable 4004

# env
set -x XDG_SESSION_TYPE wayland
set -x MOZ_ENABLE_WAYLAND 1
set -x MIX_OS_DEPS_COMPILE_PARTITION_COUNT (
  lscpu | awk '/^Core\(s\) per socket:/ {cores=$NF} /^Socket\(s\):/ {sockets=$NF} END {print cores * sockets / 2}'
)

# path
fish_add_path -p /usr/lib/cargo/bin

# abbreviations
abbr -a "u^" "sudo apt update; apt list --upgradable"
abbr -a u! "sudo apt upgrade -y"
abbr -a u- "sudo apt autoremove -y"
abbr -a o xdg-open
abbr -a open xdg-open
