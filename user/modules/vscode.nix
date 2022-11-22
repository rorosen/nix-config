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
    ];

    userSettings = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.formatOnSave" = true;
      "editor.codeActionsOnSave" = [ "source.organizeImports" ];
      "editor.fontFamily" = "'Iosevka Nerd Font'";
      "editor.wordWrap" = "on";

      "[json]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[html]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[css]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[typescriptreact]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[shellscript]"."editor.defaultFormatter" = "foxundermoon.shell-format";
      "[nix]"."editor.defaultFormatter" = "jnoortheen.nix-ide";
      "[ignore]"."editor.defaultFormatter" = "foxundermoon.shell-format";
      "[properties]"."editor.defaultFormatter" = "foxundermoon.shell-format";

      "prettier.bracketSpacing" = false;

      "shellformat.path" = "${pkgs.shfmt}/bin/shfmt";
      "shellformat.flag" = "-i=4";

      "git.confirmSync" = false;

      "update.mode" = "none";
      "update.showReleaseNotes" = false;

      "explorer.confirmDragAndDrop" = false;
    };
  };
}

