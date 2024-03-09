{
  description = "Initial flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    stylix.inputs.home-manager.follows = "home-manager";

    plugin-onedark.url = "github:navarasu/onedark.nvim";
    plugin-onedark.flake = false;
  };
  
  outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs:
    let 
      # system settings
      system_settings = {
        system = "x86_64-linux";
        hostname = "nixos";
        locale = "en_US.UTF-8";
        bootmode = "uefi";
        boot_mount_path = "/boot/efi";
      };

      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system_settings.system};

      # user settings to feed into home-manager
      user_settings = {
        username = "degra";
        dotfiles_dir = "/home/degra/.dotfiles";
        theme = "TODO: select theme";
        wm = "hyprland";
        browser = "firefox";
        term = "alacritty";
        font = "FiraCode Nerd Font";
        mono_font = "JetBrainsMono";
        editor = "nvim";
      };

    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        system = system_settings.system;
        modules = [ 
          ./configuration.nix
        ];
        specialArgs = { 
          inherit inputs; 
          inherit system_settings; 
          inherit user_settings; 
          # inherit stylix;
        }; 
      };
    };

    homeConfigurations = {
      degra = home-manager.lib.homeManagerConfiguration {
        inherit pkgs; 
        modules = [ ./home.nix ];
      	extraSpecialArgs = { 
          inherit inputs; 
          inherit system_settings;
          inherit user_settings;
          # inherit stylix;
        };
      };
    };
  };
}
