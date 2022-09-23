{ config, pkgs, ... }:

{
  home.stateVersion = "22.05";
  home.username = "yhj";
  home.homeDirectory = "/Users/yhj";

  imports = [
    ../home.nix
  ];

  home.packages = with pkgs; [
    inetutils
  ];

  programs = {
    home-manager.enable = true;
    zsh = {
      enable = true;
      sessionVariables = {
        EDITOR = "nvim";
      };
      shellAliases = {
        ls = "exa";
        l = "ls -al";
        cat = "bat";
        lg = "lazygit";
        update = ''
          brew upgrade
          home-manager switch --flake ~/workspace/dotfiles#macos
        '';
      };
      initExtra = ''
        export PATH=$HOME./cargo/bin:$HOME/go/bin:$PATH
        bindkey -e
        bindkey "^U" backward-kill-line
        backward-kill-whole-word () {
            local WORDCHARS="*?_-.[]~=/&;!#$%^(){}<>:,'\""
            zle -f kill
            zle backward-kill-word
        }
        zle -N backward-kill-whole-word
        bindkey "^W" backward-kill-whole-word
        export WORDCHARS=""
        eval "$(/opt/homebrew/bin/brew shellenv)"
        stty -ixon
      '';
    };
  };
}
