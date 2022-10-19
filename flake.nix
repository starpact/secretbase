{
  description = "For the first time in forever.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
  };

  outputs = { nixpkgs, home-manager, nur, ... }: {
    nixosConfigurations = {
      nixos-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./nixos-laptop/configuration.nix ];
      };
    };

    homeConfigurations = {
      nixos-laptop =
        let
          system = "x86_64-linux";
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [ nur.overlay ];
          };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./nixos-laptop/home.nix ];
        };

      mac-mini =
        let
          system = "aarch64-darwin";
          pkgs = import nixpkgs { inherit system; };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./mac-mini/home.nix ];
        };
    };
  };
}
