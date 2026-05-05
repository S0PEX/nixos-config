{
  inputs,
}:

{
  user,
  system,
  systemName,
  systemVersion,
}:

let
  inherit (inputs.nixpkgs) lib;
  inherit (lib) nixosSystem;
  inherit (inputs) import-tree flake-parts;
  pkgs-stable = import inputs.nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
  };
  home-manager = inputs.home-manager.nixosModules;
in
nixosSystem {
  modules = [
    # Base configuration
    (import-tree ../nixos)

    # System-specific configuration
    ../users/${user}/nixos.nix
    (import-tree ../hardware/${systemName})

    # Force the hostname to match the system name
    {
      networking.hostName = lib.mkForce systemName;
    }

    # Home Manager integration
    home-manager.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {
          inherit pkgs-stable;
        };

        users.${user} = {
          imports = [ ../users/${user}/home.nix ];
          home.stateVersion = lib.mkForce systemVersion;
        };
      };
    }
  ];
}
