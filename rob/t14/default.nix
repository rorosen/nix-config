{ pkgs, lib, ... }:
let
  get-kubeconfig = pkgs.writeShellScriptBin "get-kubeconfig" ''
    if [[ $# -ne 1 ]]; then
        echo "Usage: $(basename "$0") <hostname_or_ip>"
        exit 1
    fi

    CONFIG="$HOME/.kube/config"
    set -ex

    could_be_ipv6() {
      [[ $1 =~ ^([0-9a-fA-F]{0,4}:){0,7}[0-9a-fA-F]{1,4}$ ]]
    }

    install --backup --suffix=".backup" --mode 600 /dev/null "$CONFIG"

    # resolve hostname as kubectl has problems with hostnames sometimes
    SERVER_IP=$(getent ahosts kadem-server.local | grep "$1" | cut -f 1 -d ' ')
    could_be_ipv6 "$SERVER_IP" && SERVER_IP="[$SERVER_IP]"
    ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" \
        "root@$1" 'cat /etc/rancher/k3s/k3s.yaml' |
        sed -E -e "s/(127.0.0.1|\[::1\])/$SERVER_IP/" > "$CONFIG"
  '';
in
{
  imports = [
    ../../home
    ./kanshi.nix
  ];

  home = {
    username = "rob";
    homeDirectory = "/home/rob";
    packages = [ get-kubeconfig ];
  };

  programs = {
    firefox.profiles.rob.bookmarks = lib.mkAfter [
      {
        name = "t14 sites";
        toolbar = true;
        bookmarks = [
          {
            name = "Nixpkgs";
            url = "https://github.com/NixOS/nixpkgs";
          }
          {
            name = "k3s";
            url = "https://github.com/k3s-io/k3s";
          }
          {
            name = "Kadem";
            url = "https://git.seven.secucloud.secunet.com/seven/kadem/kadem";
          }
          {
            name = "Metakube";
            url = "https://metakube.syseleven.de";
          }
        ];
      }
    ];
    waybar = {
      hwmon-path-abs = [ "/sys/devices/platform/thinkpad_hwmon/hwmon" ];
      input-filename = "temp1_input";
    };
  };

  wayland.windowManager.sway.toolwait = [
    {
      command = "${pkgs.ungoogled-chromium}/bin/chromium";
      workspace = 4;
      waitFor = "chromium-browser";
    }
  ];
}
