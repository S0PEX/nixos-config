# Shared by every host: CLI tools, nix settings, networking, kernel tweaks
{ self, ... }:
{
  flake.nixosModules.base = {
    # Lets hosts list base next to bundles that already import it
    key = "nixos-config#base";

    imports = with self.nixosModules; [
      cli
      config
      networking
      kernel
    ];
  };
}
