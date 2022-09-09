{ config, pkgs, ... }:

{
  home.username = "yhj";
  home.homeDirectory = "/Users/yhj";

  home.stateVersion = "22.05";

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [ gcc12 inetutils ];

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "exa";
      l = "ls -al";
      cat = "bat";
      lg = "lazygit";
    };
    sessionVariables = {
      EDITOR = "nvim";
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
      eval "$(starship init zsh)"
      eval "$(/opt/homebrew/bin/brew shellenv)"
      stty -ixon
    '';
  };
}
