{pkgs, ...}: {
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium.override {
      commandLineArgs = "--ozone-platform-hint=auto";
    };
  };
}
