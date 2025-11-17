{ config, pkgs, lib, ... }:

let
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
  targets.genericLinux.nixGL.packages = import <nixgl> { inherit pkgs; };
  targets.genericLinux.nixGL.defaultWrapper = "mesa";
  targets.genericLinux.nixGL.offloadWrapper = offloadWrapper;

  home.packages = [
    pkgs.swappy
  ];

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
  # > dconf watch /
  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      "binding" = "<Super>Return";
      "command" = "ghostty";
      "name" = "Terminal";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      "binding" = "<Shift><Super>w";
      "command" = "flatpak run be.alexandervanhee.gradia --screenshot=INTERACTIVE";
      "name" = "Screenshot Window";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      "binding" = "<Shift><Super>f";
      "command" = "flatpak run be.alexandervanhee.gradia --screenshot=FULL";
      "name" = "Screenshot Full Display";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
      "binding" = "<Shift><Super>a";
      "command" = "flatpak run be.alexandervanhee.gradia --screenshot=INTERACTIVE";
      "name" = "Screenshot Area";
    };
    "org/gnome/settings-daemon/plugins/media-keys/www" = {
      "binding" = "['<Shift><Super>Return']";
    };
  };
}
