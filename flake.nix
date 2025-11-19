{
  description = "For the first time in forever.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-stable, home-manager, ... }:
    let
      mkHome = system: modules:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [
              (final: _: rec {
                stable = import nixpkgs-stable { inherit (final) system config; };
                direnv = stable.direnv;
              })
            ];
          };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ] ++ modules;
        };
    in
    {
      homeConfigurations = {
        mac-2025 = mkHome "aarch64-darwin" [ ./mac-2025.nix ];
        mac-work = mkHome "aarch64-darwin" [ ./mac-work.nix ];
      };
    };
}
