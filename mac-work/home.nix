{ pkgs, ... }:

{
  home.username = "hongjie.yan";
  home.homeDirectory = "/Users/hongjie.yan";

  imports = [ ../mac-home.nix ];

  home.packages = with pkgs; [
    apacheKafka
    awscli2
    git
    kubectl
    kubernetes-helm
    mysql80
    postgresql
    redis
    vector
  ];

  programs.bash = {
    initExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
      source /opt/homebrew/completions/bash/brew
      source ~/.work
    '';
    shellAliases = {
      hs = "home-manager switch --flake ~/dotfiles#mac-work";
    };
  };
}
