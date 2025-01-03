{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./atuin.nix
    ./bash.nix
    ./blueman.nix
    ./chromium.nix
    ./direnv.nix
    ./dunst.nix
    ./git.nix
    ./gnome-keyring.nix
    ./gtk.nix
    ./nemo.nix
    ./neovim
    ./packages.nix
    ./qt.nix
    ./ssh-agent.nix
    ./sway.nix
    ./swayidle.nix
    ./swaylock.nix
    # ./vscode
    ./waybar
    ./wlogout.nix
    ./wofi
    ./zsh
  ];

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

  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";
}
