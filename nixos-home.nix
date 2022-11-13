{ pkgs, ... }:

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
    ./modules/tmux.nix
  ];

  home.packages = with pkgs; [
    cpu-x
    discord
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
    obs-studio
    obsidian
    slack
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
    alacritty.enable = true;
    bash = {
      enable = true;
      sessionVariables = {
        EDITOR = "nvim";
        MOZ_ENABLE_WAYLAND = "1";
        PATH = "$HOME/.cargo/bin:$HOME/go/bin:$PATH";
      };
      shellAliases = {
        ls = "exa";
        l = "ls -al";
        cat = "bat";
        lg = "lazygit";
        grep = "rg";
      };
    };
    firefox.enable = true;
    home-manager.enable = true;
    mpv.enable = true;
  };

  services.syncthing.enable = true;
}
