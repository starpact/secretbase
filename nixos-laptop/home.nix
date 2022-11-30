{ pkgs, ... }:

{
  imports = [ ../nixos-home.nix ];
  programs.bash.shellAliases = {
    update = "sudo nixos-rebuild switch --flake ~/dotfiles#nixos-laptop";
    hs = "home-manager switch --flake ~/dotfiles#nixos-laptop";
  };
}
