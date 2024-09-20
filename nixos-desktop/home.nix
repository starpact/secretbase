{
  imports = [
    ../modules/nixos-home.nix
    ../modules/common.nix
    ../modules/dconf.nix
  ];

  programs.bash.shellAliases = {
    update = "sudo nixos-rebuild switch --flake .#nixos-desktop";
    hs = "home-manager switch --flake .#nixos-desktop";
  };
}
