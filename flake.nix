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
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.${system};

      # Helper method to create nixosSystem with given system name and user
      mkSystem = import ./lib/mkSystem.nix {
        inherit inputs;
      };
    in
    {
      # UM790 NixOS configuration
      nixosConfigurations.um790 = mkSystem {
        user = "s0pex";
        inherit system;
        systemName = "um790";
        systemVersion = "25.05";
      };

      # Expose nixfmt-rfc-style for 'nix fmt'
      formatter.${system} = pkgs.nixfmt-rfc-style;

      # Development shell for NixOS configuration repository
      devShells.${system}.default = pkgs.mkShellNoCC {
        name = "nixos-dev-shell";

        # Pre-commit hooks ensure code quality before distributed version control
        shellHook = ''
          ${pkgs.pre-commit}/bin/pre-commit install
        '';

        packages = with pkgs; [
          statix
          treefmt
          pre-commit
          nixfmt-rfc-style
        ];
      };
    };
}
