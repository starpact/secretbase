{ pkgs, ... }:

{
  home.username = "hongjie.yan";
  home.homeDirectory = "/Users/hongjie.yan";

  home.packets = with pkgs; [
    redis
  ];

  imports = [ ../mac-home.nix ];
  programs.bash.shellAliases = {
    hs = "home-manager switch --flake ~/workspace/dotfiles#mac-work";
  };
}
