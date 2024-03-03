{
  description = "For the first time in forever.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay?rev=22225800f7c24e7460026a5b6c9c94187d67555f";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    {
      # ==================== nixos-desktop ====================
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
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
          overlays = [ inputs.neovim-nightly-overlay.overlay ];
          pkgs = import nixpkgs {
            inherit system overlays;
            config.allowUnfree = true;
          };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./macos-work/home.nix ];
        };
    };
}
