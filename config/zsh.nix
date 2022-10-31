{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;

    initExtra = ''
      bindkey "\e[1~" beginning-of-line
      bindkey "\e[4~" end-of-line
      bindkey "\e[H" beginning-of-line
      bindkey "\e[F" end-of-line
      bindkey "\e[5~" beginning-of-history
      bindkey "\e[6~" end-of-history
      bindkey "\e[3~" delete-char
      bindkey "\e[2~" quoted-insert
      bindkey "\e[5C" forward-word
      bindkey "\e[3;5~" kill-word
      bindkey "\e[5D" backward-word
      bindkey "\e[1;5C" forward-word
      bindkey "\e[1;5D" backward-word

      autoload -U select-word-style
      select-word-style bash
    '';

    shellAliases = {
      ".." = "cd ..";
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./p10k;
        file = "p10k.zsh";
      }
    ];
  };
}

