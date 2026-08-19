{
  flake.nixHosts.um790 =
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
        ueberseeVPN = {
          config = ''
            tls-cipher "DEFAULT:@SECLEVEL=0"
            data-ciphers AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305:AES-128-CBC
            config /home/s0pex/VPN/uebersee-museum/uebersee-museum.ovpn
            auth-user-pass /home/s0pex/VPN/uebersee-museum/user_pass.txt
            verb 4
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
        "172.28.10.95" = [
          "dina-test.uebersee-museum.de"
        ];
        "172.28.10.96" = [
          "dina.uebersee-museum.de"
        ];
      };
    };
}
