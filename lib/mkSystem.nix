{
  inputs,
  nixpkgs,
  home-manager,
  systemVersion,
}:

systemName:
{ user }:

let
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
        useGlobalPkgs = true;
        useUserPackages = true;
        users.${user} = import ../users/${user}/home.nix {
          inherit inputs systemVersion;
        };
      };
    }
  ];
}
