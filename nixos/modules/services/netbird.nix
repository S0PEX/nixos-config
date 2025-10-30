{ config, pkgs, ... }:

{
  services.netbird = {
    enable = true;
    ui = {
      enable = true;
    };
  };
}
