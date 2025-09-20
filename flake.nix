{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05?shallow=1";
    home-manager = {
      # Follow corresponding `release` branch from Home Manager
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      # NixOS system version - used to align nixpkgs and home-manager versions
      # Please keep in sync with the version passed to nixpkgs and home-manager URLs
      systemVersion = "25.05";

      # Helper method to create nixosSystem with given system name and user
      mkSystem = import ./lib/mkSystem.nix {
        inherit
          inputs
          systemVersion
          ;
      };
    in
    {
      nixosConfigurations.um790 = mkSystem "um790" {
        user = "s0pex";
      };
    };
}
