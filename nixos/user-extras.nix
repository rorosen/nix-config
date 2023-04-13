{
  # Customize Polybar
  services.polybar = {
    tempHwmonPath = "/sys/devices/pci0000:00/0000:00:08.1/0000:03:00.0/hwmon/hwmon0/temp1_input";
    backlightCard = "amdgpu_bl0";
    battery = "BAT0";
    spotify.enabled = true;
    network = {
      interfaceWired = "";
      interfaceWireless = "wlo1";
    };
  };

  programs.git = {
    userEmail = "robert.rose@mailbox.org";
    userName = "Robert Rose";
  };
}
