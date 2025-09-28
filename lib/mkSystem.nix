{
  inputs,
  systemVersion,
}:

{
  system,
  systemName,
  user,
}:

let
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };

  inherit (inputs.nixpkgs) lib;
  nixosSystem = lib.nixosSystem;
  home-manager = inputs.home-manager.nixosModules;
in
nixosSystem {
  modules = [
    # Core system configuration
    ../hardware/${systemName}/configuration.nix
    ../nixos/configuration.nix
    ../users/${user}/nixos.nix

    # System-specific settings
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
          inherit pkgs-unstable;
        };

        users.${user} = {
          imports = [ ../users/${user}/home.nix ];
          home.stateVersion = lib.mkForce systemVersion;
        };
      };
    }
  ];
}
