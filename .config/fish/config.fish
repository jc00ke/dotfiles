# Paths
# =====
set fish_config $HOME/.config/fish

set -x TERM "xterm-256color"
set -x TERMINAL "foot"
set -x fish_greeting ''
set -x EDITOR "nvim"
set -x MANROFFOPT "-c"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -x ERL_AFLAGS "-kernel shell_history enabled"
set -x KERL_BUILD_DOCS "yes"
set -x XDG_SESSION_TYPE "wayland"
set -x MOZ_ENABLE_WAYLAND "1"

fish_add_path "$HOME/src/bin"
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.config/yarn/global/node_modules/.bin"
fish_add_path "$HOME/.yarn/bin"
fish_add_path "$HOME/.git-fuzzy/bin"
fish_add_path "$HOME/.dotnet/tools"
fish_add_path "$HOME/projects/ratio/ratio-ops/bin"
fish_add_path "$HOME/.pulumi/bin"
fish_add_path "$HOME/.local/share/rtx/bin"
fish_add_path "$HOME/.fly/bin"
set PATH $PATH ".git/safe/../../bin"
set FLYCTL_INSTALL "$HOME/.fly"

# this function may be required
function fish_title
  true
end

# Abbreviations
# =============
# Clean abbreviations
set -e fish_user_abbreviations

abbr -a .. "cd .."
abbr -a ... "cd ../.."
abbr -a "u^" "sudo apt update; apt list --upgradable"
abbr -a u! "sudo apt upgrade -y"
abbr -a u- "sudo apt autoremove -y"
abbr -a b "bundle exec"
abbr -a cat "bat"
abbr -a cdr "cd .. and cd -"
abbr -a conflicts "git ls-files --unmerged | cut -f2 | uniq"
abbr -a dc "docker-compose"
abbr -a e nvim
abbr -a es "nvim -S"
abbr -a free "free -m"
abbr -a ga "git add"
abbr -a gap "git add -p"
abbr -a gb "git branch"
abbr -a gba "git branch -a"
abbr -a gc "git commit -v"
abbr -a gca "git commit -v -a"
abbr -a gco "git checkout"
abbr -a gd "git diff"
abbr -a gdt "git difftool"
abbr -a gf "git fuzzy"
abbr -a gfa "git commit --amend --reset-author -CHEAD"
abbr -a gfp "git fetch --prune"
abbr -a gg "git log --pretty=oneline --abbrev-commit --branches=* --graph --decorate --color"
abbr -a gm "git merge"
abbr -a gmv "git mv"
abbr -a gsd "git svn dcommit"
abbr -a gsr "git svn rebase"
abbr -a gst "git status --ignore-submodules=dirty"
abbr -a hh "heroku"
abbr -a l "eza -l -a -s type"
abbr -a lv "nvim -R"
abbr -a xclipx "xclip -selection clipboard"
abbr -a xx "exit"
abbr -a e! "nvim +PackerInstall"
abbr -a "e^" "nvim +PackerUpdate"
abbr -a o "xdg-open"
abbr -a open "xdg-open"

abbr -a wgu "sudo wg-quick up (hostname)"
abbr -a wgd "sudo wg-quick down (hostname)"

function oops
  eval command sudo $history[1]
end
abbr -a fuck "oops"
abbr -a yolo "oops"

if test -f /opt/homebrew/bin/brew
  eval (/opt/homebrew/bin/brew shellenv)
end

if test -f "$HOME/.config/op/plugins.sh"
  source "$HOME/.config/op/plugins.sh"
end

rtx activate fish | source
rtx hook-env | source
rtx exec -- direnv hook fish | source
rtx exec -- starship init fish | source
rtx exec -- zoxide init fish | source
