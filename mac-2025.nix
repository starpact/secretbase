{ pkgs, lib, ... }:

{
  home.username = "yhj";
  home.homeDirectory = "/Users/yhj";

  home.packages = with pkgs; [
    colima
    docker
    platformio
  ];

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
  };

  programs = {
    zsh = {
      initContent = lib.mkOrder 550 ''
        fpath+=("$(brew --prefix)/share/zsh/site-functions")
      '';
      shellAliases = {
        hs = "home-manager switch --flake .#mac-2025";
      };
    };
  };
}
