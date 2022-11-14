{ pkgs, ... }:

{
  home.username = "hongjie.yan";
  home.homeDirectory = "/Users/hongjie.yan";

  imports = [ ../mac-home.nix ];

  home.packages = with pkgs; [
    apacheKafka
    awscli
    git
    grafana
    kubectl
    kubernetes-helm
    mysql80
    postgresql
    redis
    vector
  ];

  programs.bash.shellAliases = {
    hs = "home-manager switch --flake ~/workspace/dotfiles#mac-work";
  };
}
