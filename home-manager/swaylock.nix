{ ... }:

{
  programs.swaylock = {
    enable = true;

    setting = {
      # ignore-empty-password;
      # indicator-idle-visible;
      # line-uses-ring

      color = "1d1f21";
      indicator-radius = 150;
      indicator-thickness = 30;

      inside-color = "1 d1f21";
      inside-clear-color = "1 d1f21";
      inside-ver-color = "1 d1f21";
      inside-wrong-color = "1 d1f21";

      key-hl-color = "7 aa6daaa";
      bs-hl-color = "d54e53aa2";

      separator-color = "55555555";

      line-color = "1d1f21";

      text-color = "81a2be";
      text-clear-color = "b5bd68";
      text-caps-lock-color = "f0c674";
      text-ver-color = "81a2be";
      text-wrong-color = "cc6666";

      ring-color = "81a2be55";
      ring-ver-color = "81a2be";
      ring-clear-color = "b5bd6811";
      ring-wrong-color = "cc6666";
    };
  };
}
