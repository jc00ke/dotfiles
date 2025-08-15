# linux
# @fish-lsp-disable 4004

# env
set -x XDG_SESSION_TYPE wayland
set -x MOZ_ENABLE_WAYLAND 1

# path
fish_add_path -p /usr/lib/cargo/bin

# abbreviations
abbr -a "u^" "sudo apt update; apt list --upgradable"
abbr -a u! "sudo apt upgrade -y"
abbr -a u- "sudo apt autoremove -y"
abbr -a o xdg-open
abbr -a open xdg-open
