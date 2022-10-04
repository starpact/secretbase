{ pkgs, lib, ... }:

{
  home.stateVersion = "22.05";
  home.username = "yhj";
  home.homeDirectory = "/home/yhj";

  imports = [
    ../modules/dconf.nix
    ../modules/git.nix
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
    firefox
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
        hs = "home-manager switch --flake ~/workspace/dotfiles#nixos-laptop";
        update = ''
          sudo nixos-rebuild switch --flake ~/workspace/dotfiles#nixos-laptop
          hs
        '';
      };
    };
    home-manager.enable = true;
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
