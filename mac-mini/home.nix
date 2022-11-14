{
  home.username = "yhj";
  home.homeDirectory = "/Users/yhj";

  imports = [
    ../mac-home.nix
    ../modules/git.nix
  ];

  programs.bash.shellAliases = {
    hs = "home-manager switch --flake ~/workspace/dotfiles#mac-mini";
  };
}
