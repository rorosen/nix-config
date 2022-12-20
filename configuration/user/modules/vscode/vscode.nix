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
      tamasfe.even-better-toml
      ms-vsliveshare.vsliveshare
    ];

    userSettings = builtins.fromJSON (builtins.readFile ./settings.json);
  };
}

