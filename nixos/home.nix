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
    liburing
    lldb
    llvmPackages_latest.clang-manpages
    llvmPackages_latest.llvm-manpages
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
        PATH = "$HOME/.cargo/bin:$HOME/go/bin:$PATH";
      };
      shellAliases = {
        ls = "exa";
        l = "ls -al";
        cat = "bat";
        lg = "lazygit";
      };
    };
    kitty.enable = true;
    steam.enable = true;
    wireshark.enable = true;
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
