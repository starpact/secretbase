{ pkgs, ... }:

{
  imports = [ ../nixos-home.nix ];

  home.packages = with pkgs; [
    dropbox
  ];

  programs.bash.shellAliases = {
    update = "sudo nixos-rebuild switch --flake ~/workspace/dotfiles#nixos-desktop";
    hs = "home-manager switch --flake ~/workspace/dotfiles#nixos-desktop";
  };
}
