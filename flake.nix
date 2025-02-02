{
  description = "NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    } @inputs :
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        makima = lib.nixosSystem {
          specialArgs = { inherit inputs; };
          inherit system;
          modules = [
            ./configuration.nix # Import the default configuration
            ./hardware-configuration.nix # Import the hardware configuration
            ./modules/bootloader.nix # Import the bootloader configuration
            ./modules/users.nix # Import the user settings
            ./modules/packages/default.nix # Import the default package configurations
            ./modules/packages/nix-ld.nix # Import nix-ld configurations
            ./modules/packages/nvidia.nix # Import nvidia drivers
            ./modules/packages/hyprland.nix # Import hyprland configuration
          ];
        };
      };
      homeConfigurations = {
        atomik = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
        };
      };
    };
}
