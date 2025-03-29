{
  description = "For the first time in forever.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-stable, home-manager, ... }:
    {
      # ==================== wsl ====================
      homeConfigurations.wsl =
        let
          system = "x86_64-linux";
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./wsl.nix ./home.nix ];
        };

      # ==================== macos ====================
      homeConfigurations.mac =
        let
          system = "aarch64-darwin";
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [
              (final: prev: {
                stable = import nixpkgs-stable { inherit (final) system config; };
              })
            ];
          };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./mac.nix ./home.nix ];
        };
    };
}
