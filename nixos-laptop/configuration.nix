{ config, pkgs, ... }:

{
  system.stateVersion = "22.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  imports = [ ./hardware-configuration.nix ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.efi.efiSysMountPoint = "/boot/efi";
    supportedFilesystems = [ "ntfs" ];
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Singapore";

  i18n = {
    defaultLocale = "en_SG.utf8";
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-chinese-addons
        fcitx5-configtool
      ];
    };
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  users.users.yhj = {
    isNormalUser = true;
    description = "yhj";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = [ ];
  };

  environment = {
    systemPackages = [ ];
    gnome.excludePackages = with pkgs; [
      epiphany
      gnome.cheese
      gnome-tour
    ];
  };

  programs.steam.enable = true;

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    printing.enable = true;
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      layout = "us";
      xkbVariant = "";
      desktopManager.xterm.enable = false;
      excludePackages = [ pkgs.xterm ];
    };
    create_ap = {
      enable = true;
      settings = {
        INTERNET_IFACE = "wlp1s0";
        PASSPHRASE = "starpact";
        SSID = "for the first time in forever";
        WIFI_IFACE = "wlp1s0";
      };
    };
  };

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };
}