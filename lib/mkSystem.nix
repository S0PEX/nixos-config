{
  inputs,
}:

{
  self,
  systemName,
  system,
  modules ? [ ],
}:

let
  inherit (inputs.nixpkgs) lib;
  inherit (lib) nixosSystem;
  home-manager = inputs.home-manager.nixosModules;
  pkgs-stable = import inputs.nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
  };
in
nixosSystem {
  modules = [
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
        backupFileExtension = "backup";
        extraSpecialArgs = {
          inherit inputs;
          inherit pkgs-stable;
        };
        # Keep every user's home.stateVersion pinned to this host's system.stateVersion
        sharedModules = [
          (
            { osConfig, ... }:
            {
              home.stateVersion = osConfig.system.stateVersion;
            }
          )
        ];
      };
    }

    # Raw, host-specific NixOS fragments (hardware scan, base configuration.nix, etc.)
    self.nixHosts.${systemName}
  ]
  ++ modules;
}
