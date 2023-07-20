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
    colima
    git
    gnutar
  ];

  programs.bash = {
    initExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
      source /opt/homebrew/completions/bash/brew
      source ~/.work
    '';
    shellAliases = {
      hs = "home-manager switch --flake .#mac-work";
    };
  };
}
