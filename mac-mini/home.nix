{ pkgs, ... }:

{
  home.username = "yhj";
  home.homeDirectory = "/Users/yhj";

  imports = [ ../mac-home.nix ];
  programs.bash.shellAliases = {
    hs = "home-manager switch --flake ~/workspace/dotfiles#mac-mini";
  };
}
