{
  imports = [
    ../modules/nixos-home.nix
    ../modules/common.nix
    ../modules/dconf.nix
    ../modules/languages.nix
    ../modules/nvim.nix
  ];

  programs.bash.shellAliases = {
    update = "sudo nixos-rebuild switch --flake .#nixos-laptop";
    hs = "home-manager switch --flake .#nixos-laptop";
  };
}
