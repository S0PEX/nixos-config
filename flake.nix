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

    import-tree.url = "github:vic/import-tree";
    flake-parts.url = "github:hercules-ci/flake-parts";

  };

  outputs =
    inputs@{ flake-parts, import-tree, ... }:
    let
      mkSystem = import ./lib/mkSystem.nix {
        inherit inputs;
      };
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.home-manager.flakeModules.home-manager
      ];
      flake = {
        nixosConfigurations.um790 = mkSystem {
          user = "s0pex";
          system = "x86_64-linux";
          systemName = "um790";
          systemVersion = "25.05";
        };
      };
      systems = [ "x86_64-linux" ];
      perSystem =
        { pkgs, system, ... }:
        {
          formatter = pkgs.nixfmt;

          devShells.default = pkgs.mkShellNoCC {
            name = "nixos-dev-shell";

            shellHook = ''
              ${pkgs.pre-commit}/bin/pre-commit install
            '';

            packages = with pkgs; [
              statix
              treefmt
              pre-commit
              nixfmt
            ];
          };
        };
    };
}
