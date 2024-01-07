{ pkgs, ... }:

{
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    bashInteractive
    zstd
  ];

  programs = {
    bash = {
      sessionVariables = {
        LANG = "en_US.UTF-8";
      };
    };
    home-manager.enable = true;
  };
}
