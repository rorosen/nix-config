{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      jnoortheen.nix-ide
      timonwong.shellcheck
      esbenp.prettier-vscode
      foxundermoon.shell-format
      streetsidesoftware.code-spell-checker
      james-yu.latex-workshop
      ms-vscode.cpptools
      golang.go
      davidanson.vscode-markdownlint
      ms-kubernetes-tools.vscode-kubernetes-tools
      redhat.vscode-yaml
      matklad.rust-analyzer
      ms-vsliveshare.vsliveshare
      zxh404.vscode-proto3
      bungcip.better-toml
      Arjun.swagger-viewer
      ms-azuretools.vscode-docker
      arrterian.nix-env-selector
      eamodio.gitlens
    ];

    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;

    userSettings = builtins.fromJSON (builtins.readFile ./settings.json) // {  "shellformat.path" = "${pkgs.shfmt}/bin/shfmt"; };
  };
}

