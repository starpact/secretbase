{ pkgs, config, ... }:

{
  home.stateVersion = "22.05";

  imports = [
    ./modules/common.nix
    ./modules/languages.nix
    ./modules/nvim.nix
  ];

  home.file = {
    ".config/alacritty/alacritty.yml".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/workspace/dotfiles/modules/alacritty/alacritty_mac.yml";
    ".config/kitty/kitty.conf".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/workspace/dotfiles/modules/kitty/kitty_mac.conf";
  };

  home.packages = with pkgs; [
    bashInteractive
    inetutils
    nix
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
        grep = "rg";
      };
      initExtra = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
        source /opt/homebrew/completions/bash/brew
      '';
    };
  };
}
