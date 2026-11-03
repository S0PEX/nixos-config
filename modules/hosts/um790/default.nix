{ inputs, self, ... }:
{
  flake.nixosConfigurations.um790 = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      # Host and user
      host-um790
      user-s0pex

      # Bundles
      workstation

      # Extra features
      bluetooth
      virtualisation

      # Networking extras
      networking-openvpn
      networking-cloudflare-google-dns
    ];
  };
}
