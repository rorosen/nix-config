{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      hp = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/hp-configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.rob = import ./home-manager/home-sway.nix;
            home-manager.sharedModules = [
              # extra packages to install
              ({ pkgs, ... }: {
                home.packages = with pkgs; [
                  nextcloud-client
                  thunderbird
                  signal-desktop
                  flameshot
                  prusa-slicer
                  freecad
                  element-desktop
                  android-tools
                ];
              })
              # extra commands to autostart
              # ({ pkgs, config, ... }: {
              #   wayland.windowManager.sway.config.startup = [
              #     { command = "${pkgs.nextcloud-client}/bin/nextcloud"; }
              #     { command = "${pkgs.sway}/bin/swaymsg 'workspace 19'"; }
              #     { command = "${config.home.homeDirectory}/.config/sway/sway-toolwait --waitfor 'thunderbird' ${pkgs.thunderbird}/bin/thunderbird"; }
              #   ];
              # })

              ({ programs.git.userEmail = "robert.rose@mailbox.org"; })
            ];
          }
        ];
      };
    };
  };
}
