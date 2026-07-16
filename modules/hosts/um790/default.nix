{ inputs, self, ... }:
let
  mkSystem = import ../../../lib/mkSystem.nix { inherit inputs; };
in
{
  flake.nixosConfigurations.um790 = mkSystem {
    inherit self;
    systemName = "um790";
    system = "x86_64-linux";
    modules = [
      self.nixUsers.s0pex

      self.nixosModules.pkgs
      self.nixosModules.config
      self.nixosModules.desktop
      self.nixosModules.services
      self.nixosModules.networking
      self.nixosModules.kernel

      self.nixosModules.bluetooth
      self.nixosModules.virtualisation

    ];
  };
}
