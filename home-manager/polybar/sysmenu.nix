{pkgs, ...}: let
  rofi-theme = ''
    configuration {
        show-icons:                 false;
    }

    * {
        background:     #1E2127FF;
        background-alt: #282B31FF;
        foreground:     #FFFFFFFF;
        selected:       #61AFEFFF;
        active:         #98C379FF;
        urgent:         #E06C75FF;
    }

    window {
        /* properties for window widget */
        transparency:                "real";
        location:                    center;
        anchor:                      center;
        fullscreen:                  false;
        width:                       500px;
        x-offset:                    0px;
        y-offset:                    0px;

        /* properties for all widgets */
        enabled:                     true;
        margin:                      0px;
        padding:                     0px;
        border:                      2px solid;
        border-radius:               20px;
        border-color:                @selected;
        cursor:                      "default";
        background-color:            @background;
    }

    mainbox {
        enabled:                     true;
        spacing:                     15px;
        margin:                      0px;
        padding:                     30px;
        border:                      0px solid;
        border-radius:               0px;
        border-color:                @selected;
        background-color:            transparent;
        children:                    [ "message", "listview" ];
    }

    message {
        enabled:                     true;
        margin:                      0px;
        padding:                     12px;
        border:                      0px solid;
        border-radius:               100%;
        border-color:                @selected;
        background-color:            @background-alt;
        text-color:                  @foreground;
    }
    textbox {
        background-color:            inherit;
        text-color:                  inherit;
        vertical-align:              0.5;
        horizontal-align:            0.0;
        placeholder-color:           @foreground;
        blink:                       true;
        markup:                      true;
    }
    error-message {
        padding:                     12px;
        border:                      0px solid;
        border-radius:               0px;
        border-color:                @selected;
        background-color:            @background;
        text-color:                  @foreground;
    }

    listview {
        enabled:                     true;
        columns:                     1;
        lines:                       5;
        cycle:                       true;
        dynamic:                     true;
        scrollbar:                   false;
        layout:                      vertical;
        reverse:                     false;
        fixed-height:                true;
        fixed-columns:               true;

        spacing:                     5px;
        margin:                      0px;
        padding:                     0px;
        border:                      0px solid;
        border-radius:               0px;
        border-color:                @selected;
        background-color:            transparent;
        text-color:                  @foreground;
        cursor:                      "default";
    }

    element {
        enabled:                     true;
        spacing:                     0px;
        margin:                      0px;
        padding:                     12px;
        border:                      0px solid;
        border-radius:               100%;
        border-color:                @selected;
        background-color:            transparent;
        text-color:                  @foreground;
        cursor:                      pointer;
    }
    element-text {
        background-color:            transparent;
        text-color:                  inherit;
        cursor:                      inherit;
        vertical-align:              0.5;
        horizontal-align:            0.0;
    }
    element selected.normal {
        background-color:            var(selected);
        text-color:                  var(background);
    }
  '';
in {
  home.file.".config/polybar/sysmenu.sh" = {
    target = ".config/polybar/sysmenu.sh";
    executable = true;

    text = ''
      #!/usr/bin/env bash

      # Options
      shutdown='  Shutdown'
      reboot='  Reboot'
      lock=' Lock'
      suspend='鈴 Suspend'
      yes='  Yes'
      no='  No'

      # Rofi CMD
      rofi_cmd() {
        ${pkgs.rofi}/bin/rofi -dmenu \
          -mesg "Uptime: $(${pkgs.procps}/bin/uptime --pretty | ${pkgs.gnused}/bin/sed -e 's/up //g')" \
          -theme-str '${rofi-theme}'
      }

      # Confirmation CMD
      confirm_cmd() {
        ${pkgs.rofi}/bin/rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 250px;}' \
          -theme-str 'mainbox {children: [ "message", "listview" ];}' \
          -theme-str 'listview {columns: 2; lines: 1;}' \
          -theme-str 'element-text {horizontal-align: 0.5;}' \
          -theme-str 'textbox {horizontal-align: 0.5;}' \
          -dmenu \
          -p 'Confirmation' \
          -mesg 'Really, really, really?' \
          -theme-str '${rofi-theme}'
      }

      # Ask for confirmation
      confirm_exit() {
        echo -e "$yes\n$no" | confirm_cmd
      }

      # Pass variables to rofi dmenu
      run_rofi() {
        echo -e "$lock\n$suspend\n$reboot\n$shutdown" | rofi_cmd
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
      chosen="$(run_rofi)"
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
