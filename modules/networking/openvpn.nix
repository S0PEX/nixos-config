# OpenVPN client support; hosts define their own services.openvpn.servers
{
  flake.nixosModules.networking-openvpn =
    { pkgs, ... }:
    {
      # Hosts with VPN servers import this too; load it once
      key = "nixos-config#networking-openvpn";

      # VPN up/down hooks push DNS through update-systemd-resolved
      services.resolved.enable = true;

      networking.networkmanager.plugins = [ pkgs.networkmanager-openvpn ];
    };
}
