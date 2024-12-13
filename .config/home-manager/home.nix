{ config, pkgs, lib, ... }:

# Home Manager needs a bit of information about you and the paths it should
# manage.
let
 username = "jesse";
in
{
   home.username = username;
   home.homeDirectory = let
     homes = {
       "x86_64-darwin" = "/Users/${username}";
       "aarch64-darwin" = "/Users/${username}";
       "x86_64-linux" = "/home/${username}";
       "aarch64-linux" = "/home/${username}";
     };
   in
     homes.${pkgs.stdenv.system} or (throw "Unsupported system: ${pkgs.stdenv.system}");

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    pkgs.aws-vault
    pkgs.bat
    pkgs.delta
    pkgs.direnv
    pkgs.difftastic
    pkgs.duf
    pkgs.eza
    pkgs.fastmod
    pkgs.fd
    pkgs.fx
    pkgs.fzf
    pkgs.jless
    pkgs.just
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.neovim
    pkgs.rage
    pkgs.ripgrep
    pkgs.rnr
    pkgs.rustywind
    pkgs.sd
    pkgs.shellcheck
    pkgs.shfmt
    pkgs.shellspec
    pkgs.srgn
    pkgs.sqlite
    pkgs.starship
    pkgs.stylua
    pkgs.tailwindcss
    pkgs.tealdeer
    pkgs.xsv
    pkgs.yazi
    pkgs.yq-go
    pkgs.zoxide

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    pkgs.swappy
  ] ++ lib.optionals pkgs.stdenv.isDarwin [
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jesse/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  fonts.fontconfig.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
