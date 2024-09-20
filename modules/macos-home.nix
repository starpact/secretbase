{ pkgs, ... }:

{
  home.stateVersion = "24.05";

  home.packages = with pkgs.stable; [
    colima
    docker
    findutils
    gnutar
  ];

  home.sessionVariables = {
    XDG_DATA_DIRS = "$HOME/.nix-profile/share:/nix/var/nix/profiles/default/share:$XDG_DATA_DIRS";
    LANG = "en_US.UTF-8";
  };

  programs .home-manager.enable = true;
}
