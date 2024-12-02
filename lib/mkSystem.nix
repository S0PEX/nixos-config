# This function creates a NixOS system based on a setup for a particular architecture.
{ nixpkgs, nixpkgs-unstable, systemVersion, inputs }:

name:
{ system ? "x86_64-linux"
, user
, config ? { }
}:

let
  # Import the Nixpkgs library
  lib = nixpkgs.lib;

  # Package configuration
  pkgConfig = {
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  };

  # Path configurations
  paths = {
    user = ../users/${user}/nixos.nix;
    userHM = ../users/${user}/home-manager.nix;
    system = ../hardware/${name}/configuration.nix;
    mainConfig = ../nixos/configuration.nix;
  };

  # Home-manager configuration
  homeManagerConfig = {
    home-manager = {
      backupFileExtension = "hm-backup";
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit (pkgConfig) pkgs-unstable; };
      users.${user} = import paths.userHM { inherit inputs systemVersion; };
    };
  };

  # Module arguments
  moduleArgs = {
    config._module.args = {
      inherit inputs;
      inherit (pkgConfig) pkgs-unstable;
    };
  };
in
lib.nixosSystem {
  inherit (pkgConfig) pkgs;

  modules = [
    paths.system # Hardware-specific configuration
    paths.mainConfig # Main system configuration
    paths.user # User-specific configuration
    inputs.home-manager.nixosModules.home-manager
    homeManagerConfig
    {
      inherit config;
    } # Forward configuration
    {
      system.stateVersion = lib.mkForce systemVersion;
    }
    moduleArgs
  ];
}
