{ pkgs, lib, ... }:

{
  home.stateVersion = "22.05";

  imports = [
    ../dconf.nix
  ];

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
      fcitx5-configtool
    ];
  };

  home.packages = with pkgs; [
    clang_14
    dropbox
    gimp
    google-chrome
    gnome.gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.gsconnect
    gnomeExtensions.just-perfection
    vscode
    wl-clipboard
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
      };
      shellAliases = {
        vim = "nvim";
        ls = "exa";
        l = "ls -al";
        cat = "bat";
        lg = "lazygit";
      };
      initExtra = ''
        export PATH=$HOME/.cargo/bin:$HOME/go/bin:$PATH
        stty -ixon
      '';
    };
    wezterm.enable = true;
  };

  services = {
    flameshot = {
      enable = true;
      settings = {
        General = {
          showStartupLaunchMessage = false;
          showDesktopNotification = false;
        };
      };
    };
  };
}
