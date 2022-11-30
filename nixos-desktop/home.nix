{ pkgs, ... }:

{
  imports = [ ../nixos-home.nix ];

  home.packages = with pkgs; [
    dropbox
  ];

  programs.bash.shellAliases = {
    update = "sudo nixos-rebuild switch --flake ~/dotfiles#nixos-desktop";
    hs = "home-manager switch --flake ~/dotfiles#nixos-desktop";
  };
}
