{ pkgs, ... }:
{
  imports = [
    ./vscode
    ./zsh
    ./sway
    ./waybar
    ./wofi
    ./neovim
    ./packages.nix
    ./alacritty.nix
    ./gtk.nix
    ./qt.nix
    ./gnome-keyring.nix
    ./git.nix
    ./ssh-agent.nix
    ./nemo.nix
    ./blueman.nix
    ./chromium.nix
    ./direnv.nix
    ./atuin.nix
    ./swaylock.nix
    ./wlogout.nix
    ./swayidle.nix
    ./dunst.nix
    ./bash.nix
  ];

  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  home = {
    keyboard.layout = "de";
    sessionVariables = {
      RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
      SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent.socket";
      NIXOS_OZONE_WL = "1";
    };
  };
}
