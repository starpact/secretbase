{ pkgs, ... }:

{
  home.stateVersion = "24.05";
  home.username = "yhj";
  home.homeDirectory = "/home/yhj";

  home.packages = with pkgs; [
    alacritty
    bcc
    bookworm
    bpftool
    cpu-x
    discord
    dropbox
    firefox
    flameshot
    gimp
    gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.gsconnect
    gnomeExtensions.just-perfection
    google-chrome
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
  };

  services.syncthing.enable = true;
}
