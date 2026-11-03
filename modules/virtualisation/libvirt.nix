{
  flake.nixosModules.virtualisation-libvirt = {
    programs.virt-manager.enable = true;
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;

    # Allow traffic on the default libvirt bridge (virbr0) to reach the host
    networking.firewall.trustedInterfaces = [ "virbr0" ];
  };
}
