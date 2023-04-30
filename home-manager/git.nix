{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Robert Rose";

    aliases = {
      st = "status";
      sw = "switch";
      ci = "commit";
      pu = "pull";
      ps = "push";
    };
  };
}
