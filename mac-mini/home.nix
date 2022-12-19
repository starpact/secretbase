{
  home.username = "yhj";
  home.homeDirectory = "/Users/yhj";

  imports = [
    ../mac-home.nix
    ../modules/git.nix
  ];

  programs.bash = {
    initExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
      source /opt/homebrew/completions/bash/brew
    '';
    shellAliases = {
      hs = "home-manager switch --flake ~/dotfiles#mac-mini";
    };
  };
}
