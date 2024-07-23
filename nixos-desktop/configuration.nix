{ pkgs, ... }:

{
  system.stateVersion = "24.05";
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    log-lines = 25;
    connect-timeout = 5;
    fallback = true;
  };
  nixpkgs.config.allowUnfree = true;

  imports = [ ./hardware-configuration.nix ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader.systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    loader.efi.canTouchEfiVariables = true;
    loader.efi.efiSysMountPoint = "/boot/efi";
    supportedFilesystems = [ "ntfs" ];
    extraModprobeConfig = ''
      options hid_apple fnmode=0
    '';
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Singapore";

  i18n = {
    defaultLocale = "en_SG.utf8";
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-chinese-addons
        fcitx5-configtool
      ];
    };
  };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  users.users.yhj = {
    isNormalUser = true;
    description = "yhj";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = [ ];
  };

  environment = {
    systemPackages = [ ];
    gnome.excludePackages = with pkgs; [
      epiphany
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
      xkb.layout = "us";
    };
  };

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };
}
