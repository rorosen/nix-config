{
  programs.nixvim.plugins = {
    hmts.enable = true;
    treesitter = {
      enable = true;
      nixvimInjections = true;
      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
      folding = true;
    };

    # causes nvim to hang when working on, or even ust opening some nix files.
    # disable for now
    # treesitter-refactor = {
    #   enable = true;
    #   highlightDefinitions = {
    #     enable = true;
    #     # Set to false if you have an `updatetime` of ~100.
    #     clearOnCursorMove = false;
    #   };
    # };
  };
}
