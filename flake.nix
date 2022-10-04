{
  description = "Nix Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {
    nixosConfigurations.nixos-laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./nixos-laptop/configuration.nix ];
    };
    homeConfigurations.nixos-laptop = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      modules = [
        ./nixos-laptop/home.nix
        ./modules/shared.nix
      ];
    };

    homeConfigurations.fedora-laptop = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      modules = [
        ./fedora-laptop/home.nix
        ./modules/shared.nix
      ];
    };

    homeConfigurations.mac-mini = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs { system = "aarch64-darwin"; };
      modules = [
        ./mac-mini/home.nix
        ./modules/shared.nix
      ];
    };
  };
}
