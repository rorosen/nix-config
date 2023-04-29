{ pkgs, ... }:

{
  home.file.".config/wofi/sysmenu.sh" = {
    executable = true;

    text = ''
      #!${pkgs.bash}/bin/bash

      # Options
      shutdown='  Shutdown'
      reboot='  Reboot'
      lock=' Lock'
      suspend='鈴 Suspend'
      yes='  Yes'
      no='  No'

      # wofi CMD
      wofi_cmd() {
        ${pkgs.wofi}/bin/wofi --dmenu \
          --prompt "Uptime: $(${pkgs.procps}/bin/uptime --pretty | ${pkgs.gnused}/bin/sed -e 's/up //g')" \
          --lines 6
      }

      # Confirmation CMD
      confirm_cmd() {
        ${pkgs.wofi}/bin/wofi --dmenu --prompt 'Are you sure?'
      }

      # Ask for confirmation
      confirm_exit() {
        echo -e "$yes\n$no" | confirm_cmd
      }

      # Pass variables to wofi dmenu
      run_wofi() {
        echo -e "$lock\n$suspend\n$reboot\n$shutdown" | wofi_cmd
      }

      # Execute Command
      run_cmd() {
        selected="$(confirm_exit)"
        if [[ "$selected" == "$yes" ]]; then
          if [[ "$1" == '--shutdown' ]]; then
            systemctl poweroff
          elif [[ "$1" == '--reboot' ]]; then
            systemctl reboot
          elif [[ "$1" == '--suspend' ]]; then
            ${pkgs.alsa-utils}/bin/amixer set Master mute
            systemctl suspend
          fi
        else
          exit 0
        fi
      }

      # Actions
      chosen="$(run_wofi)"
      case ''${chosen} in
        "$shutdown")
        run_cmd --shutdown
          ;;
        "$reboot")
        run_cmd --reboot
          ;;
        "$lock")
        ${pkgs.betterlockscreen}/bin/betterlockscreen --lock
          ;;
        "$suspend")
        run_cmd --suspend
          ;;
      esac
    '';
  };
}
