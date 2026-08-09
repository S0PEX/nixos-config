{
  flake.nixosModules.virtualisation =
    { pkgs, ... }:
    {
      virtualisation.libvirtd.enable = true;
      programs.virt-manager.enable = true;

      # To use the default libvirt network (virbr0) we need to install dnsmasq and allow traffic on the default bridge to reach the host.
      # See https://nixos.wiki/wiki/Libvirt#Networking
      environment.systemPackages = with pkgs; [
        dnsmasq
      ];

      networking.firewall.trustedInterfaces = [ "virbr0" ];
    };
}
