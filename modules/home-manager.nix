# Home Manager integration; imported by every user module that has a home config
{ inputs, ... }:
{
  flake.nixosModules.home-manager = {
    # Several users may import this; load it once
    key = "nixos-config#home-manager";

    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
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
  };
}
