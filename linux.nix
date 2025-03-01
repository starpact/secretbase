{ pkgs, ... }:

{
  home.username = "yhj";
  home.homeDirectory = "/home/yhj";

  home.packages = with pkgs; [
    platformio
  ];
}
