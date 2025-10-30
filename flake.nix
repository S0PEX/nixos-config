{
  description = "General Purpose NixOS System Configuration";

  inputs = {
    # NixOS official package sources
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable?shallow=1";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05?shallow=1";

    # Home Manager for user-specific configurations
    home-manager = {
      url = "github:nix-community/home-manager/master?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      # NixOS system version - used to align nixpkgs and home-manager versions
      # Please keep in sync with the version passed to nixpkgs and home-manager URLs
      systemVersion = "25.11";

      # Helper method to create nixosSystem with given system name and user
      mkSystem = import ./lib/mkSystem.nix {
        inherit inputs systemVersion;
      };
    in
    {
      nixosConfigurations.um790 = mkSystem {
        user = "s0pex";
        system = "x86_64-linux";
        systemName = "um790";
      };
    };
}
