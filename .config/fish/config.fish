# Paths
# =====
function append_to_path
  if not test -d $argv[1]
    return
  end
  if not contains $argv[1] $PATH
    set PATH $PATH $argv[1]
  end
end

function prepend_to_path
  if not test -d $argv[1]
    return
  end
  if not contains $argv[1] $PATH
    set PATH $argv[1] $PATH
  end
end

set fish_config $HOME/.config/fish

set -x TERM "xterm-256color"
set -x TERMINAL "wezterm"
set -x fish_greeting ''
set -x EDITOR "nvim"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -x ERL_AFLAGS "-kernel shell_history enabled"
set -gx FZF_DEFAULT_COMMAND  'rg --files --color=never'

append_to_path "$HOME/src/bin"
append_to_path "$HOME/.local/bin"
append_to_path "$HOME/.config/yarn/global/node_modules/.bin"
append_to_path "$HOME/.yarn/bin"
append_to_path "$HOME/.git-fuzzy/bin"
append_to_path "$HOME/.dotnet/tools"
append_to_path "$HOME/projects/ratio/ratio-ops/bin"
append_to_path "$HOME/.pulumi/bin"
set PATH $PATH ".git/safe/../../bin"

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
abbr -a l "exa -l -a -s type"
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
rtx exec -- starship init fish | source
rtx exec -- zoxide init fish | source
rtx exec -- direnv hook fish | source
