{ pkgs, ... }:

{
  imports = [
    ../modules/nixos-home.nix
    ../modules/common.nix
    ../modules/dconf.nix
    ../modules/languages.nix
    ../modules/nvim.nix
  ];

  programs = {
    bash.shellAliases = {
      update = "sudo nixos-rebuild switch --flake ~/dotfiles#nixos-desktop";
      hs = "home-manager switch --flake ~/dotfiles#nixos-desktop";
    };
  };
}
