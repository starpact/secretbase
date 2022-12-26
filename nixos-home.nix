{ pkgs, config, ... }:

{
  home.stateVersion = "22.05";
  home.username = "yhj";
  home.homeDirectory = "/home/yhj";

  imports = [
    ./modules/common.nix
    ./modules/dconf.nix
    ./modules/git.nix
    ./modules/languages.nix
    ./modules/nvim.nix
  ];

  home.file = {
    ".config/alacritty/alacritty.yml".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/modules/alacritty/alacritty_linux.yml";
    ".config/kitty/kitty.conf".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/modules/kitty/kitty_linux.conf";
  };

  home.packages = with pkgs; [
    alacritty
    cpu-x
    discord
    firefox
    flameshot
    gimp
    google-chrome
    gnome.gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.gsconnect
    gnomeExtensions.just-perfection
    kitty
    liburing
    libreoffice
    mpv
    obsidian
    tdesktop
    video-trimmer
    virt-manager
    vscode
    wl-clipboard
    wireshark
    wqy_microhei
    wqy_zenhei
    xclip
    zoom-us
  ];

  programs = {
    bash = {
      sessionVariables = {
        MOZ_ENABLE_WAYLAND = "1";
      };
    };
    home-manager.enable = true;
  };

  services.syncthing.enable = true;
}
