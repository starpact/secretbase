{
  description = "For the first time in forever.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    {
      # ==================== nixos-desktop ====================
      nixosConfigurations.nixos-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./nixos-desktop/configuration.nix ];
      };
      homeConfigurations.nixos-desktop =
        let
          system = "x86_64-linux";
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./nixos-desktop/home.nix ];
        };

      # ==================== nixos-laptop ====================
      nixosConfigurations.nixos-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./nixos-laptop/configuration.nix ];
      };
      homeConfigurations.nixos-laptop =
        let
          system = "x86_64-linux";
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./nixos-laptop/home.nix ];
        };

      # ==================== macos-work ====================
      homeConfigurations.macos-work =
        let
          system = "aarch64-darwin";
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./macos-work/home.nix ];
        };
    };
}
