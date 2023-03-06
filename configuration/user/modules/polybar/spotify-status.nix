{ config, pkgs, lib, ... }:

{
  home.file.".config/polybar/spotify-status.sh" = {
    target = ".config/polybar/spotify-status.sh";
    executable = true;

    text = ''
      #!${pkgs.bashInteractive}/bin/bash

      PARENT_BAR_PID=$(${pkgs.procps}/bin/pgrep -a "polybar" | ${pkgs.gnugrep}/bin/grep "bottom" | ${pkgs.coreutils-full}/bin/cut -d" " -f1)

      # Set the source audio player here.
      # Players supporting the MPRIS spec are supported.
      # Examples: spotify, vlc, chrome, mpv and others.
      # Use `playerctld` to always detect the latest player.
      # See more here: https://github.com/altdesktop/playerctl/#selecting-players-to-control
      PLAYER="spotify"

      # Format of the information displayed
      # Eg. {{ artist }} - {{ album }} - {{ title }}
      # See more attributes here: https://github.com/altdesktop/playerctl/#printing-properties-and-metadata
      FORMAT="{{ title }} - {{ artist }}"

      PLAYERCTL_STATUS=$(${pkgs.playerctl}/bin/playerctl --player=$PLAYER status 2>/dev/null)

      if [ $? -eq 0 ]; then
          STATUS=$PLAYERCTL_STATUS
      else
          echo "No player is running"
          exit 0
      fi

      if [ "$STATUS" = "Stopped" ]; then
          echo "No music is playing"
          exit 0
      elif [ "$STATUS" = "Paused"  ]; then
          ${pkgs.polybar}/bin/polybar-msg -p "$PARENT_BAR_PID" action "#spotify-play-pause.hook.0" 1>/dev/null 2>&1
      else
          ${pkgs.polybar}/bin/polybar-msg -p "$PARENT_BAR_PID" action "#spotify-play-pause.hook.1" 1>/dev/null 2>&1
      fi
      ${pkgs.playerctl}/bin/playerctl --player="$PLAYER" metadata --format "$FORMAT"
    '';
  };
}
