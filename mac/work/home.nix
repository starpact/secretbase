{ pkgs, ... }:

{
  home.stateVersion = "22.05";
  home.username = "yhj";
  home.homeDirectory = "/Users/yhj";

  imports = [
    ../modules/common.nix
    ../modules/git.nix
    ../modules/nvim.nix
    ../modules/tmux.nix
  ];

  home.packages = with pkgs; [
    bashInteractive
    inetutils
  ];

  programs = {
    home-manager.enable = true;
    bash = {
      enable = true;
      sessionVariables = {
        EDITOR = "nvim";
        XDG_DATA_DIRS = "$HOME/.nix-profile/share:$XDG_DATA_DIRS";
        PATH = "$HOME/.cargo/bin:$HOME/go/bin:$PATH";
      };
      shellAliases = {
        ls = "exa";
        l = "ls -al";
        cat = "bat";
        lg = "lazygit";
        hs = "home-manager switch --flake ~/workspace/dotfiles#mac-work";
      };
      initExtra = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
        source /opt/homebrew/completions/bash/brew
      '';
    };
  };
}
