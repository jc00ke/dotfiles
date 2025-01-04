{ config, pkgs, lib, ... }:

# Home Manager needs a bit of information about you and the paths it should
# manage.
let
  username = "jesse";
  vgaOutput = builtins.readFile (pkgs.runCommand "gpu-check" {} ''
   ${pkgs.pciutils}/bin/lspci > $out
  '');
  offloadWrapper = if builtins.match ".*VGA.*Intel.*" vgaOutput != null
    then "intel"
  else if builtins.match ".*VGA.*Radeon.*" vgaOutput != null
    then "radeon"
  else
    null;
in
{
   # https://github.com/nix-community/nixGL?tab=readme-ov-file#nix-channel-recommended
   # nix-channel --add https://github.com/nix-community/nixGL/archive/main.tar.gz nixgl && nix-channel --update
   nixGL.packages = import <nixgl> { inherit pkgs; };
   nixGL.defaultWrapper = "mesa";
   nixGL.offloadWrapper = offloadWrapper;

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
    pkgs.b3sum
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

  # https://nix-community.github.io/home-manager/index.xhtml#sec-usage-gpu-non-nixos
  programs.ghostty = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.ghostty;
  };

  # https://github.com/ghostty-org/ghostty/discussions/3763#discussioncomment-11699970
  xdg.desktopEntries."com.mitchellh.ghostty" = {
    name = "Ghostty";
    type = "Application";
    comment = "A terminal emulator";
    exec = "ghostty";
    icon = "com.mitchellh.ghostty";
    terminal = false;
    startupNotify = true;
    categories = [ "System" "TerminalEmulator" ];
    settings = {
      Keywords = "terminal;tty;pty;";
      X-GNOME-UsesNotifications = "true";
      X-TerminalArgExec = "-e";
      X-TerminalArgTitle = "--title=";
      X-TerminalArgAppId = "--class=";
      X-TerminalArgDir = "--working-directory=";
      X-TerminalArgHold = "--wait-after-command";
    };
    actions = {
      new-window = {
        name = "New Window";
        exec = "ghostty";
      };
    };
  };

  # https://discourse.nixos.org/t/apps-installed-via-home-manager-are-not-visible-within-gnome/48252/2
  home.activation.copyDesktopFiles = lib.hm.dag.entryAfter ["installPackages"] ''
    if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then

      mkdir -p "${config.home.homeDirectory}/.local/share/applications"

      if [ -d "${config.home.homeDirectory}/.local/share/applications/nix" ]; then
        rm -rf "${config.home.homeDirectory}/.local/share/applications/nix"
      fi

      ln -sf "${config.home.homeDirectory}/.nix-profile/share/applications" \
        ${config.home.homeDirectory}/.local/share/applications/nix

      mkdir -p "${config.home.homeDirectory}/.local/share/icons"

      if [ -d "${config.home.homeDirectory}/.local/share/icons/nix" ]; then
        rm -rf "${config.home.homeDirectory}/.local/share/icons/nix"
      fi

      ln -sf "${config.home.homeDirectory}/.nix-profile/share/icons" \
        ${config.home.homeDirectory}/.local/share/icons/nix

    fi
  '';

  # https://wiki.nixos.org/wiki/GNOME
  # https://hoverbear.org/blog/declarative-gnome-configuration-in-nixos/#setting-gnome-options
  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      "binding" = "<Super>Return";
      "command" = "ghostty";
      "name" = "Terminal";
    };
    "org/gnome/settings-daemon/plugins/media-keys/www" = {
      "binding" = "['<Shift><Super>Return']";
    };
  };
}
