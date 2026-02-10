# paths
set fish_config $HOME/.config/fish

# env
set -x fish_greeting ''
set -x TERM xterm-256color
set -x EDITOR nvim
set -x VISUAL "$EDITOR"
set -x ALTERNATE_EDITOR vim
set -x MANROFFOPT -c
set -x MANPAGER 'nvim +Man!'

# system specific configuration
switch (uname)
    case Linux
        source $HOME/.config/fish/linux.fish
    case Darwin
        source $HOME/.config/fish/darwin.fish
end

# erlang/elixir/BEAM
set -x ERL_AFLAGS "-kernel shell_history enabled"
set -x KERL_BUILD_DOCS yes

fish_add_path -aP "$HOME/src/bin"
fish_add_path -aP "$HOME/.local/bin"
fish_add_path -aP "$HOME/.config/yarn/global/node_modules/.bin"
fish_add_path -aP "$HOME/.yarn/bin"
fish_add_path -aP "$HOME/.git-fuzzy/bin"
fish_add_path -aP "$HOME/.mix/escripts"
fish_add_path "$HOME/.fly/bin"
fish_add_path ".git/safe/../../bin"
fish_add_path "$HOME/.local/share/bob/nvim-bin"
fish_add_path "$HOME/.local/share/bob/nightly/bin"

# abbreviations

# reset abbreviations
set -e fish_user_abbreviations

abbr -a .. "cd .."
abbr -a ... "cd ../.."
abbr -a b "bundle exec"
abbr -a cdr "cd .. and cd -"
abbr -a conflicts "git ls-files --unmerged | cut -f2 | uniq"
abbr -a dc docker compose

# editor
abbr -a e nvim
abbr -a es "nvim -S"

# git
abbr -a ga "git add"
abbr -a gap "git add -p"
abbr -a gb "git branch"
abbr -a gc "git commit -v"
abbr -a gca "git commit -v -a"
abbr -a gd "git diff"
abbr -a gf "git fuzzy"
abbr -a gfa "git commit --amend --reset-author -CHEAD"
abbr -a gfp "git fetch --prune"
abbr -a gg "git log --pretty=oneline --abbrev-commit --branches=* --graph --decorate --color"
abbr -a gst "git status --ignore-submodules=dirty"

abbr -a hh heroku
abbr -a l "eza -l -a -s type"
abbr -a lv "nvim -R"
abbr -a xx exit

# wireguard
abbr -a wgu "sudo wg-quick up (hostname)"
abbr -a wgd "sudo wg-quick down (hostname)"

# redo!
function oops
    eval command sudo $history[1]
end
abbr -a fuck oops
abbr -a yolo oops

if test -f "$HOME/.config/op/plugins.sh"
    source "$HOME/.config/op/plugins.sh"
end

if type -q mise
    set -x MISE_ENV posix
    abbr -a mr "mise run"
    fish_add_path -aP "$HOME/.local/share/mise/bin"
    mise activate fish | source
    mise hook-env | source
    mise exec -- starship init fish | source
    mise exec -- zoxide init fish | source

    if type -q atuin
        # bind to ctrl-r in normal and insert mode, add any other bindings you want here too
        bind \cr _atuin_search
        bind -M insert \cr _atuin_search
        set -gx ATUIN_NOBIND true
        mise exec -- atuin init fish | source
    end
end

if type -q yazi
    abbr -a yy yazi
end
