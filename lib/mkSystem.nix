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
  inherit (inputs.nixpkgs) lib;
  inherit (lib) nixosSystem;
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
        extraSpecialArgs = { };

        users.${user} = {
          imports = [ ../users/${user}/home.nix ];
          home.stateVersion = lib.mkForce systemVersion;
        };
      };
    }
  ];
}
