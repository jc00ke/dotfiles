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
fish_add_path "$HOME/.local/share/mise/bin"
set PATH $PATH ".git/safe/../../bin"
set FLYCTL_INSTALL "$HOME/.fly"
fish_add_path "$FLYCTL_INSTALL/bin"

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

if test -x /Applications/Tailscale.app/Contents/MacOS/Tailscale
  alias tailscale "/Applications/Tailscale.app/Contents/MacOS/Tailscale"
end

if test -x /opt/homebrew/bin/brew
  eval (/opt/homebrew/bin/brew shellenv)
  set -gx RUBY_YJIT_ENABLE 1
  set -gx RUBY_CONFIGURE_OPTS "--with-zlib-dir=$(brew --prefix zlib) --with-openssl-dir=$(brew --prefix openssl) --with-readline-dir=$(brew --prefix readline) --with-libyaml-dir=$(brew --prefix libyaml) --with-gdbm-dir=$(brew --prefix gdbm)"
  set -gx CFLAGS "-O2 -g -Wno-error=implicit-function-declaration"
  set -gx LDFLAGS "-L$(brew --prefix libyaml)/lib -L$(brew --prefix libffi)/lib"
  set -gx CPPFLAGS "-I$(brew --prefix libffi)/include"
end

if test -f "$HOME/.config/op/plugins.sh"
  source "$HOME/.config/op/plugins.sh"
end

set -gx ATUIN_NOBIND "true"
atuin init fish | source

# bind to ctrl-r in normal and insert mode, add any other bindings you want here too
bind \cr _atuin_search
bind -M insert \cr _atuin_search

mise activate fish | source
mise hook-env | source
mise exec -- direnv hook fish | source
mise exec -- starship init fish | source
mise exec -- zoxide init fish | source

if command -v yazi > /dev/null
  abbr -a yy "yazi"
end
