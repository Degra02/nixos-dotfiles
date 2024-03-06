{
  description = "Initial flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    plugin-onedark.url = "github:navarasu/onedark.nvim";
    plugin-onedark.flake = false;
  };
  
  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let 
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        modules = [ ./configuration.nix ];
      };
    };
    homeConfigurations = {
      degra = home-manager.lib.homeManagerConfiguration {
        inherit pkgs; 
        modules = [ ./home.nix ];
	extraSpecialArgs = { inherit inputs; };
      };
    };
  };
}
