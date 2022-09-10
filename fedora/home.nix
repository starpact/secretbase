{ pkgs, lib, ... }:

{
  home.stateVersion = "22.05";
  home.username = "yhj";
  home.homeDirectory = "/home/yhj";

  home.packages = with pkgs; [
    clang_14
    nix-bash-completions
    wl-clipboard
    wqy_microhei
    wqy_zenhei
    xclip
  ];

  programs = {
    home-manager.enable = true;
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
        hs = "home-manager switch --flake ~/workspace/dotfiles#fedora";
      };
      initExtra = ''
        export PATH=$HOME/.cargo/bin:$HOME/go/bin:$PATH
        export XDG_DATA_DIRS=$HOME/.nix-profile/share:$XDG_DATA_DIRS
        stty -ixon
      '';
    };
  };

  dconf.settings = {
    "org/gnome/mutter" = {
      dynamic-workspaces = false;
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
    };
    "org/gnome/desktop/peripherals/keyboard" = {
      delay = lib.hm.gvariant.mkUint32 300;
      repeat-interval = lib.hm.gvariant.mkUint32 30;
    };
    "org/gnome/shell/keybindings" = {
      toggle-message-tray = [ ];
    };
    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [ ];
      switch-to-application-2 = [ ];
      switch-to-application-3 = [ ];
      switch-to-application-4 = [ ];
    };
    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
      toggle-maximized = [ "<Super>F" ];
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      switch-to-workspace-left = [ "<Super><Control>H" ];
      switch-to-workspace-right = [ "<Super><Control>L" ];
      move-to-workspace-1 = [ "<Super><Shift>1" ];
      move-to-workspace-2 = [ "<Super><Shift>2" ];
      move-to-workspace-3 = [ "<Super><Shift>3" ];
      move-to-workspace-4 = [ "<Super><Shift>4" ];
      move-to-workspace-left = [ "<Super><Shift>H" ];
      move-to-workspace-right = [ "<Super><Shift>L" ];
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      home = [ "<Super>E" ];
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "alacritty";
      name = "Terminal";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>E";
      command = "nautilus";
      name = "Files";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "<Super>B";
      command = "google-chrome-stable";
      name = "Browser";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
      binding = "F1";
      command = "flameshot gui";
      name = "Flameshot";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4" = {
      binding = "<Super>I";
      command = "alacritty -e htop";
      name = "Htop";
    };
  };
}
