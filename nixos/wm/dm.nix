{ config, pkgs, ... }:

let
  sddm-theme = pkgs.sddm-astronaut;
in
{
  # Enable the X server
  services.xserver = {
    enable = true;
    xkb = {
      layout = "de";
      variant = "";
    };
  };

  # Simple Desktop Display Manager (SDDM)
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;

    theme = "sddm-astronaut-theme";

    extraPackages = [ sddm-theme ];
  };

  # Need to add the theme package to systemPackages as extraPackages is not enough
  # to ensure the theme is available at login screen
  environment.systemPackages = [
    sddm-theme
  ];
}
