{
  description = "NixOS configuration files";

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
              ({ pkgs, ... }: {
                imports = [
                  ./home-manager/nextcloud-client.nix
                ];
                # extra packages to install
                home.packages = with pkgs; [
                  nextcloud-client
                  thunderbird
                  signal-desktop
                  prusa-slicer
                  freecad
                  element-desktop
                  android-tools
                ];
                # extra applications to autostart
                wayland.windowManager.sway.startupSync = [
                  {
                    command = "${pkgs.thunderbird}/bin/thunderbird";
                    workspace = 19;
                    appId = "thunderbird";
                  }
                ];

                programs.git.userEmail = "robert.rose@mailbox.org";
              })
            ];
          }
        ];
      };
      t14 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/t14-configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.rob = import ./home-manager/home-sway.nix;
            home-manager.sharedModules = [
              ({ pkgs, ... }: {
                wayland.windowManager.sway.startupSync = [
                  {
                    command = "${pkgs.ungoogled-chromium}/bin/chromium";
                    workspace = 4;
                    appId = "chromium-browser";
                  }
                ];
                programs.git.userEmail = "robert.rose@secunet.com";
              })
            ];
          }
        ];
      };
    };
  };
}
