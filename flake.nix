{
  description = "NixOS systems and tools by S0PEX";

  inputs = {
    # Define the primary nixpkgs repository for stable configurations
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";

    # Define the nixpkgs-unstable repository for testing or using more recent packages
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # Define home-manager for managing user configurations
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      ...
    }@inputs:
    let
      # NixOS system version - used to align nixpkgs and home-manager versions
      # Please keep in sync with the version passed to nixpkgs and home-manager URLs
      system = "x86_64-linux";
      systemVersion = "24.11";

      pkgs = import nixpkgs-unstable { inherit system; };

      mkSystem = import ./lib/mkSystem.nix {
        inherit
          nixpkgs
          nixpkgs-unstable
          systemVersion
          inputs
          ;
      };
    in
    {
      # Define NixOS configurations
      nixosConfigurations = {
        workstation = mkSystem "workstation" {
          user = "s0pex"; # Specify the user for the configuration
          # Pass extra arguments to the configuration
          # i.e., config.hardware.nvidia.enable = true;
          config = {
            hardware.nvidia.enable = true; # Enable nvidia driver
          };
        };

        vm = mkSystem "vm" {
          user = "s0pex"; # Specify the user for the configuration
        };
      };

      # Development environment
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          # Formatters
          nixfmt-rfc-style
          treefmt
        ];
      };
    };
}
