{
  inputs,
  systemVersion,
}:

systemName:
{ user }:

let
  inherit (inputs) nixpkgs home-manager;
  inherit (nixpkgs) lib;
in
lib.nixosSystem {
  modules = [
    ../hardware/${systemName}/configuration.nix
    ../nixos/configuration.nix
    ../users/${user}/nixos.nix

    { networking.hostName = lib.mkForce systemName; }

    home-manager.nixosModules.home-manager
    {
      home-manager = {
        users.${user} = {
          imports = [
            ../users/${user}/home.nix
          ];

          # Ensure home.stateVersion is set to systemVersion
          home.stateVersion = lib.mkForce systemVersion;
        };

        # Home-manager options
        useGlobalPkgs = true;
        useUserPackages = true;
      };
    }
  ];
}
