{ pkgs, ... }:

{
  home.file.".local/share/nemo/actions/open_in_alacritty.nemo_action" = {
    target = ".local/share/nemo/actions/open_in_alacritty.nemo_action";

    text = ''
      [Nemo Action]

      Name=Open in Alacritty
      Comment=Open in Alacritty
      Exec=${pkgs.alacritty}/bin/alacritty --working-directory="%F"
      Selection=any
      Extensions=dir;
    '';
  };
}
