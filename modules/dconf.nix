{ pkgs, lib, ... }:

{
  dconf.settings = {
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
    };
    "org/gnome/desktop/peripherals/keyboard" = {
      delay = lib.hm.gvariant.mkUint32 300;
      repeat-interval = lib.hm.gvariant.mkUint32 30;
    };
    "org/gnome/shell" = {
      favorite-apps = [
        "google-chrome.desktop"
        "Alacritty.desktop"
        "code.desktop"
        "org.gnome.Nautilus.desktop"
        "obsidian.desktop"
        "netease-cloud-music.desktop"
      ];
    };
    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [ "<Super>1" ];
      switch-to-application-2 = [ "<Super>2" ];
      switch-to-application-3 = [ "<Super>3" ];
      switch-to-application-4 = [ "<Super>E" ];
      switch-to-application-5 = [ "<Super>N" ];
      switch-to-application-6 = [ "<Super>M" ];
    };
    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>Q" ];
      toggle-maximized = [ "<Super>F" ];
      switch-to-workspace-left = [ "<Super><Control>H" ];
      switch-to-workspace-right = [ "<Super><Control>L" ];
      move-to-workspace-left = [ "<Super><Shift>H" ];
      move-to-workspace-right = [ "<Super><Shift>L" ];
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      screensaver = [ ];
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "alacritty";
      name = "Terminal";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "F1";
      command = "flameshot gui";
      name = "Flameshot";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "<Super>I";
      command = "alacritty -e htop";
      name = "Htop";
    };
  };
}
