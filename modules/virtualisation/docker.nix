{
  flake.nixosModules.virtualisation = {
    virtualisation.docker = {
      enable = true;
      daemon.settings = {
        ipv6 = false;
      };
    };

    # Allow traffic on bridge interfaces (e.g., for Docker containers) to access the host
    networking.firewall.trustedInterfaces = [ "br+" ];
  };
}
