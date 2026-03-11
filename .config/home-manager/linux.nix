{ config, pkgs, lib, ... }:

let
  
in
{

  home.packages = [
    pkgs.swappy
  ];

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
