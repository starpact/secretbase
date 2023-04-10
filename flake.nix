{
  description = "For the first time in forever.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url =
      "github:nix-community/neovim-nightly-overlay?rev=b0e03aec365db0fdf29d19da3cc6b6d229961494";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    {
      nixosConfigurations = {
        nixos-desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./nixos-desktop/configuration.nix ];
        };
        nixos-laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./nixos-laptop/configuration.nix ];
        };
      };

      homeConfigurations =
        let
          overlays = [ inputs.neovim-nightly-overlay.overlay ];
        in
        {
          nixos-desktop =
            let
              system = "x86_64-linux";
              pkgs = import nixpkgs {
                inherit system overlays;
                config.allowUnfree = true;
              };
            in
            home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              modules = [ ./nixos-desktop/home.nix ];
            };

          nixos-laptop =
            let
              system = "x86_64-linux";
              pkgs = import nixpkgs {
                inherit system overlays;
                config.allowUnfree = true;
              };
            in
            home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              modules = [ ./nixos-laptop/home.nix ];
            };

          mac-work =
            let
              system = "aarch64-darwin";
              pkgs = import nixpkgs {
                inherit system overlays;
              };
            in
            home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              modules = [ ./mac-work/home.nix ];
            };
        };
    };
}
