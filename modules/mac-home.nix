{ pkgs, config, ... }:

{
  home.stateVersion = "23.05";

  home.file = {
    ".config/alacritty/alacritty.yml".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/modules/alacritty/alacritty_mac.yml";
  };

  home.packages = with pkgs; [
    bashInteractive
    zstd
  ];

  programs = {
    bash = {
      sessionVariables = {
        XDG_DATA_DIRS = "$HOME/.nix-profile/share:/nix/var/nix/profiles/default/share:$XDG_DATA_DIRS";
        LANG = "en_US.UTF-8";
      };
    };
    home-manager.enable = true;
  };
}
