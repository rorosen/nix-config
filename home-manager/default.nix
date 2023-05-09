{ pkgs, osConfig, lib, ... }:

let
  isSway = osConfig.system.flavor == "sway";
  isI3 = osConfig.system.flavor == "i3";
in
{
  imports = [
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
  ] ++ (if isSway then [
    ./sway
    ./waybar
    ./wofi
    ./swaylock.nix
    ./wlogout.nix
    ./swayidle.nix
    ./dunst.nix
  ] else if isI3 then [
    ./i3
    ./polybar
    ./rofi
    ./betterlockscreen.nix
  ] else [ ]);

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  programs.home-manager.enable = true;
  home = {
    keyboard.layout = "de";
    sessionVariables.RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  };

  xsession = lib.mkIf isI3 {
    enable = true;
    numlock.enable = true;
    profileExtra = ''
      export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket;
    '';
  };

  programs.bash = lib.mkIf isSway {
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
