{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../modules/nixos-configuration.nix
  ];
}
