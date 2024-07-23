{ pkgs, ... }:

{
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    bashInteractive
    colima
    docker
    findutils
    gnutar
  ];

  programs = {
    bash = {
      sessionVariables = {
        XDG_DATA_DIRS = "$HOME/.nix-profile/share:/nix/var/nix/profiles/default/share:$XDG_DATA_DIRS";
        LANG = "en_US.UTF-8";
      };
    };
    home-manager.enable = true;
  };
}
