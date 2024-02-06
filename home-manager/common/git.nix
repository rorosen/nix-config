{...}: {
  programs.git = {
    enable = true;
    userName = "Robert Rose";

    aliases = {
      st = "stash";
      sw = "switch";
      ci = "commit";
      pl = "pull";
      ps = "push";
    };
  };
}
