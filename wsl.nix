{ pkgs, ... }:

{
  home.username = "yhj";
  home.homeDirectory = "/home/yhj";

  home.packages = with pkgs; [
    platformio
  ];

  programs.bash.shellAliases = {
    hs = "home-manager switch --flake .#wsl";
  };
}
