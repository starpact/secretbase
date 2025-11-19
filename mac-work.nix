{ pkgs, lib, ... }:

{
  home.username = "hongjie.yan";
  home.homeDirectory = "/Users/hongjie.yan";

  home.packages = with pkgs; [
    colima
    docker

    stable.findutils
    stable.gnutar
    stable.lab
    stable.ssm-session-manager-plugin
    stable.terraform
  ];

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
  };

  programs = {
    zsh = {
      initContent = lib.mkOrder 550 ''
        fpath+=("$(brew --prefix)/share/zsh/site-functions")
        source ~/.work
      '';
      shellAliases = {
        hs = "home-manager switch --flake .#mac-work";
      };
    };
  };
}
