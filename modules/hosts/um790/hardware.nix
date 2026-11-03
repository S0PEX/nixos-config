{ self, ... }:
{
  flake.nixosModules.host-um790 =
    { lib, pkgs, ... }:
    let
      resolved = "${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved";
      mkVpn = config: {
        inherit config;
        autoStart = false;
        updateResolvConf = true;
        up = resolved;
        down = resolved;
      };
    in
    {
      # The VPN hooks below need resolved, so pull in OpenVPN support here
      imports = [ self.nixosModules.networking-openvpn ];

      services.openvpn.servers = lib.mapAttrs (_: mkVpn) {
        officeVPN = ''
          config /home/s0pex/VPN/artur_komaristych_new.ovpn
          askpass /home/s0pex/VPN/artur_komaristych_new.txt
        '';
        ueberseeVPN = ''
          tls-cipher "DEFAULT:@SECLEVEL=0"
          data-ciphers AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305:AES-128-CBC
          config /home/s0pex/VPN/uebersee-museum/uebersee-museum.ovpn
          auth-user-pass /home/s0pex/VPN/uebersee-museum/user_pass.txt
          verb 4
        '';
        esbVPN = ''
          config /home/s0pex/Documents/Medeora/ESB-VPN/medeora_ssl_vpn_config.ovpn
          auth-user-pass /home/s0pex/Documents/Medeora/ESB-VPN/vpn-credentials.txt
        '';
        tumVPN = ''
          config /home/s0pex/Documents/Medeora/TUM/sslvpn-bioarchive@sportmed-client-config(V2).ovpn
          auth-user-pass /home/s0pex/Documents/Medeora/TUM/auth.txt
        '';
      };

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
