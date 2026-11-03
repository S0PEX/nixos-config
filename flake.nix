{
  description = "General Purpose NixOS System Configuration";

  inputs = {
    # NixOS official package sources
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable?shallow=1";

    # Home Manager for user-specific configurations
    home-manager = {
      url = "github:nix-community/home-manager/master?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Additional inputs
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # Utilities for flake development
    import-tree.url = "github:vic/import-tree";
    flake-parts.url = "github:hercules-ci/flake-parts";
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, import-tree, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.home-manager.flakeModules.home-manager
        inputs.git-hooks.flakeModule
        (import-tree ./modules)
      ];
      systems = [ "x86_64-linux" ];
      perSystem =
        { config, pkgs, ... }:
        {
          formatter = pkgs.nixfmt;

          pre-commit.settings.hooks = {
            nixfmt.enable = true;
            statix.enable = true;
          };

          devShells.default = pkgs.mkShellNoCC {
            name = "nixos-dev-shell";

            shellHook = config.pre-commit.installationScript;

            packages = [ pkgs.graphify ] ++ config.pre-commit.settings.enabledPackages;
          };
        };
    };
}
