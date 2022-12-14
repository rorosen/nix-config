{
  # Customize Polybar
  services.polybar = {
    # for i in /sys/class/hwmon/hwmon*/temp*_input; do echo "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*})) $(readlink -f $i)"; done
    tempHwmonPath = "";
    # ls -1 /sys/class/backlight/
    backlightCard = "";
    # ls -1 /sys/class/power_supply/
    battery = "";
    spotify.enabled = false;
    network = {
      interfaceWired = "";
      interfaceWireless = "";
    };
  };
}
