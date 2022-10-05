#!/bin/bash
log() {
  echo "********************************************"
  echo "$1"
  echo "********************************************"
  echo ""
}
cd "$HOME" || exit
if [ ! -d "$HOME/.asdf" ]; then
  log "Installing asdf"
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
fi

log "Installing Erlang"
asdf plugin add erlang

log "Installing Elixir"
asdf plugin add elixir

log "Installing Ruby"
asdf plugin add ruby

log "Installing Rust"
asdf plugin add rust https://github.com/code-lever/asdf-rust.git

log "Installing node"
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

log "Installing deno"
asdf plugin add deno https://github.com/asdf-community/asdf-deno.git

log "Installing lua"
asdf plugin add lua https://github.com/Stratus3D/asdf-lua.git

log "Installing ripgrep"
asdf plugin add ripgrep

log "Installing bat"
asdf plugin add bat

log "Installing zoxide"
asdf plugin add zoxide https://github.com/nyrst/asdf-zoxide.git

log "Installing elm"
asdf plugin-add elm https://github.com/asdf-community/asdf-elm.git

log "Installing python"
asdf plugin add python

log "Installing postgres"
asdf plugin add postgres

log "Installing redis"
asdf plugin add redis

log "Installing shellspec"
asdf plugin add shellspec

log "Installing shellcheck"
asdf plugin add shellcheck https://github.com/luizm/asdf-shellcheck.git

log "Installing duf"
asdf plugin add duf

log "Installing fd"
asdf plugin add fd

log "Installing exa"
asdf plugin add exa

log "Installing delta"
asdf plugin add delta

log "Installing yq"
asdf plugin add yq

log "Installing shfmt"
asdf plugin add shfmt

log "Installing stylua formatter"
asdf plugin add stylua https://github.com/jc00ke/asdf-stylua.git

log "Installing jless"
asdf plugin add jless https://github.com/jc00ke/asdf-jless.git

log "Installing starship"
asdf plugin add starship

log "Installing GitHub CLI"
asdf plugin add github-cli https://github.com/bartlomiejdanek/asdf-github-cli.git

log "Installing difftastic"
asdf plugin add difftastic

if command -v nvim >/dev/null 2>&1; then
  log "Installing neovim"
  asdf plugin add neovim
  log "Bootstraping Neovim"
  nvim '+PackerInstall' '+PackerClean' '+PackerUpdate' '+PackerCompile' '+qall'
fi

asdf install
asdf reshim
