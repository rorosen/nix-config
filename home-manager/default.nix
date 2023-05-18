{
  homeManagerModules,
  pkgs,
  osConfig,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  isSway = osConfig.windowManager.type == "sway";
  isI3 = osConfig.windowManager.type == "i3";
in {
  imports =
    [
      homeManagerModules.hwmon-linker

      ./packages.nix
      ./vscode
      ./zsh
      ./alacritty.nix
      ./gtk.nix
      ./qt.nix
      ./gnome-keyring.nix
      ./git.nix
      ./ssh-agent.nix
      ./nemo.nix
      ./blueman.nix
      ./neovim.nix
    ]
    ++ lib.optionals isSway [
      ./sway
      ./waybar
      ./wofi
      ./swaylock.nix
      ./wlogout.nix
      ./swayidle.nix
      ./dunst.nix
    ]
    ++ lib.optionals isI3 [
      ./i3
      ./polybar
      ./rofi
      ./betterlockscreen.nix
    ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  programs.home-manager.enable = true;
  home = {
    keyboard.layout = "de";
    sessionVariables = {
      RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
      # FIXME: code crashes sometimes when setting this
      # NIXOS_OZONE_WL = mkIf isSway "1";
    };
  };

  xsession = mkIf isI3 {
    enable = true;
    numlock.enable = true;
    profileExtra = ''
      export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket;
    '';
  };

  programs.bash = mkIf isSway {
    enable = true;
    profileExtra = ''
      export SDL_VIDEODRIVER=wayland
      export _JAVA_AWT_WM_NONREPARENTING=1
      export QT_QPA_PLATFORM=wayland
      export XDG_CURRENT_DESKTOP=sway
      export XDG_SESSION_DESKTOP=sway
      export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket
      [ "$(tty)" = "/dev/tty1" ] && exec ${pkgs.sway}/bin/sway
    '';
  };

  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";
}
