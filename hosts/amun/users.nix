{...}: {
  users.mutableUsers = false;
  users.users.rob = {
    isNormalUser = true;
    extraGroups = ["wheel"];

    openssh.authorizedKeys.keys = [(builtins.readFile ../hp/rob-id_ed25519.pub)];
  };
}
