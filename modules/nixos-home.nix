{ pkgs, config, ... }:

{
  home.stateVersion = "22.11";
  home.username = "yhj";
  home.homeDirectory = "/home/yhj";

  home.file = {
    ".config/alacritty/alacritty.yml".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/modules/alacritty/alacritty_linux.yml";
    ".config/kitty/kitty.conf".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/modules/kitty/kitty_linux.conf";
  };

  home.packages = with pkgs; [
    alacritty
    bcc
    bookworm
    bpftool
    # clickhouse
    cpu-x
    discord
    dropbox
    firefox
    flameshot
    gimp
    gnome.gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.gsconnect
    gnomeExtensions.just-perfection
    google-chrome
    kitty
    libreoffice
    linuxPackages_latest.perf
    mpv
    obsidian
    tdesktop
    video-trimmer
    virt-manager
    vscode
    wireshark
    wl-clipboard
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
    git = {
      enable = true;
      userName = "starpact";
      userEmail = "yhj.await@gmail.com";
    };
    home-manager.enable = true;
  };

  services.syncthing.enable = true;
}
