{
  flake.nixosModules.services = {
    services.netbird = {
      enable = true;
      ui = {
        enable = true;
      };
    };
  };
}
