{ pkgs, ... }:

{
  home.stateVersion = "22.05";
  home.username = "yhj";
  home.homeDirectory = "/Users/yhj";

  imports = [
    ./modules/common.nix
    ./modules/git.nix
    ./modules/nvim.nix
    ./modules/tmux.nix
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
      };
      initExtra = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
        source /opt/homebrew/completions/bash/brew
      '';
    };
  };
}

# bindkey -e
# bindkey "^U" backward-kill-line
# backward-kill-whole-word () {
#     local WORDCHARS="*?_-.[]~=/&;!#$%^(){}<>:,'\""
#     zle -f kill
#     zle backward-kill-word
# }
# zle -N backward-kill-whole-word
# bindkey "^W" backward-kill-whole-word
# export WORDCHARS=""
