{ pkgs, ... }:

{
  home.username = "hongjie.yan";
  home.homeDirectory = "/Users/hongjie.yan";

  imports = [
    ../modules/macos-home.nix
    ../modules/common.nix
    ../modules/languages.nix
    ../modules/nvim.nix
  ];

  home.packages = with pkgs; [
    findutils
    git
    gnutar
    ssm-session-manager-plugin
  ];

  programs.bash = {
    initExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
      source /opt/homebrew/completions/bash/brew
      source ~/.work
    '';
    shellAliases = {
      hs = "home-manager switch --flake .#macos-work";
    };
  };
}
