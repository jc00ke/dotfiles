# Credit: https://github.com/rust-lang/rustup/blob/master/src/cli/self_update/env.fish
if not contains "/home/jesse/.local/share/bob/nvim-bin" $PATH
    set -x PATH "/home/jesse/.local/share/bob/nvim-bin" $PATH
end