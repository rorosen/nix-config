{ pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      bindkey "\e[5~" beginning-of-history
      bindkey "\e[6~" end-of-history
      bindkey "\e[3~" delete-char
      bindkey "\e[2~" quoted-insert
      bindkey "\e[5C" forward-word
      bindkey "\e[3;5~" kill-word
      bindkey "\e[5D" backward-word
      bindkey "\e[1;5C" forward-word
      bindkey "\e[1;5D" backward-word
      bindkey "^R" history-incremental-search-backward

      autoload -U select-word-style
      select-word-style bash
      export EDITOR=vim
      ${pkgs.any-nix-shell}/bin/any-nix-shell zsh --info-right | source /dev/stdin
      bindkey "\e[1~" beginning-of-line
      bindkey "\e[4~" end-of-line
      bindkey "\e[H" beginning-of-line
      bindkey "\e[F" end-of-line
    '';

    shellAliases = {
      ".." = "cd ..";
      "k" = "kubectl";
      "kn" = "kubens";
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./.;
        file = "p10k.zsh";
      }
      {
        name = "zsh-autopair";
        src = pkgs.zsh-autopair;
        file = "share/zsh/zsh-autopair/autopair.zsh";
      }
    ];
  };
}
