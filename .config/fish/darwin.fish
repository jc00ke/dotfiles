# darwin

# @fish-lsp-disable-next-line
alias tailscale "/Applications/Tailscale.app/Contents/MacOS/Tailscale"

set -x MIX_OS_DEPS_COMPILE_PARTITION_COUNT (
  math (sysctl -n hw.physicalcpu) / 2
)

if test -x /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
    fish_add_path /opt/homebrew/bin/
    set -gx RUBY_YJIT_ENABLE 1
    set -gx RUBY_CONFIGURE_OPTS "--with-zlib-dir=$(brew --prefix zlib) --with-openssl-dir=$(brew --prefix openssl) --with-readline-dir=$(brew --prefix readline) --with-libyaml-dir=$(brew --prefix libyaml) --with-gdbm-dir=$(brew --prefix gdbm)"
    set -gx CFLAGS "-O2 -g -Wno-error=implicit-function-declaration"
    set -gx LDFLAGS "-L$(brew --prefix libyaml)/lib -L$(brew --prefix libffi)/lib"
    set -gx CPPFLAGS "-I$(brew --prefix libffi)/include"
end
