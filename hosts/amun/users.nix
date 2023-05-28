{...}: {
  users.mutableUsers = false;
  users.users.rob = {
    isNormalUser = true;
    extraGroups = ["wheel"];

    openssh.authorizedKeys.keys = [(builtins.readFile ../hp/rob-id_25519.pub)];
  };
}
