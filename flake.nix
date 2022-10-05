{
  description = "For the first time in forever.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    nixos-cn = {
      url = "github:nixos-cn/flakes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, nur, nixos-cn, ... }: {
      nixosConfigurations.nixos-laptop = let system = "x86_64-linux"; in nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./nixos-laptop/configuration.nix
          # { environment.systemPackages = [ nixos-cn.legacyPackages.${system}.netease-cloud-music ]; }
        ];
      };
      homeConfigurations.nixos-laptop = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
          overlays = [ nur.overlay ];
        };
        modules = [ ./nixos-laptop/home.nix ];
      };

      homeConfigurations.fedora-laptop = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; };
        modules = [ ./fedora-laptop/home.nix ];
      };

      homeConfigurations.mac-mini = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "aarch64-darwin"; };
        modules = [ ./mac-mini/home.nix ];
      };
    };
}
