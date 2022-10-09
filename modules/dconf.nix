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
        "org.gnome.Nautilus.desktop"
        "netease-cloud-music.desktop"
      ];
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
      home = [ "<Super>E" ];
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
