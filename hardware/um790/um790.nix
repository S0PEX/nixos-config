{ config, pkgs, ... }:

let
  inherit (pkgs) update-systemd-resolved;
in
{
  services.openvpn.servers = {
    officeVPN = {
      config = ''
        config /home/s0pex/VPN/artur_komaristych_new.ovpn
        askpass /home/s0pex/VPN/artur_komaristych_new.txt
      '';
      autoStart = false;
      updateResolvConf = true;
      up = "${update-systemd-resolved}/libexec/openvpn/update-systemd-resolved";
      down = "${update-systemd-resolved}/libexec/openvpn/update-systemd-resolved";
    };
  };

  environment.systemPackages = [
    update-systemd-resolved
  ];

  programs.java.enable = true;

  networking.hosts = {
    "127.0.0.1" = [
      "inanet"
      "inanet-keycloak"
      "inanet.local"
    ];
  };
}
