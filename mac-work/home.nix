{ pkgs, ... }:

{
  imports = [ ../mac-home.nix ];
  programs.bash.shellAliases = {
    hs = "home-manager switch --flake ~/workspace/dotfiles#mac-work";
  };
}
