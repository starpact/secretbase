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
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Singapore";

  i18n.defaultLocale = "en_SG.utf8";

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
    gnome.excludePackages = [
      pkgs.gnome.cheese
      pkgs.gnome-tour
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
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      desktopManager.xterm.enable = false;
      enable = true;
      excludePackages = [ pkgs.xterm ];
      layout = "us";
      xkbVariant = "";
    };
  };

  virtualisation = {
    docker.enable = true;
  };
}
