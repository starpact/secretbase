{ pkgs, ... }:

{
  home.username = "hongjie.yan";
  home.homeDirectory = "/Users/hongjie.yan";

  imports = [
    ../modules/mac-home.nix
    ../modules/common.nix
    ../modules/languages.nix
    ../modules/nvim.nix
  ];

  home.packages = with pkgs; [
    awscli2
    colima
    git
    kubectl
    kubernetes-helm
    mysql80
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
