{ pkgs, ... }:
let
  get-kubeconfig = pkgs.writeShellScriptBin "get-kubeconfig" ''
    if [[ $# -ne 1 ]]; then
        echo "Usage: $(basename "$0") <hostname_or_ip>"
        exit 1
    fi

    CONFIG="$HOME/.kube/config"
    set -ex

    install --backup --suffix=".backup" --mode 600 /dev/null "$CONFIG"

    ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" \
        "root@$1" 'cat /etc/rancher/k3s/k3s.yaml' |
        sed "s/127.0.0.1/$1/" > "$CONFIG"
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

  programs.waybar = {
    hwmon-path-abs = [ "/sys/devices/platform/thinkpad_hwmon/hwmon" ];
    input-filename = "temp1_input";
  };

  wayland.windowManager.sway.toolwait = [
    {
      command = "${pkgs.ungoogled-chromium}/bin/chromium";
      workspace = 4;
      waitFor = "chromium-browser";
    }
  ];
}
