{
  programs.nixvim = {
    plugins.neo-tree = {
      enable = true;
      closeIfLastWindow = true;
      window = {
        width = 30;
        autoExpandWidth = true;
      };
      filesystem.filteredItems.visible = true;
    };
  };
}
