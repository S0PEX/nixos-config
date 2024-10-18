{ config, pkgs, pkgs-unstable, ... }:
let
  sddm-astronaut = pkgs-unstable.sddm-astronaut;
in
{
  # Enable the X server
  services.xserver.enable = true;

  # Enable SDDM (Simple Desktop Display Manager) with Wayland support
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    package = pkgs-unstable.kdePackages.sddm; # Use Qt6 version of SDDM
    extraPackages = [ sddm-astronaut ];
  };

  # Configure the keyboard layout for X11
  services.xserver.xkb = {
    layout = "de"; # Set layout to German
    variant = ""; # Use the default variant
  };

  # Add ssdm themes to systemPackages
  environment.systemPackages = [ sddm-astronaut ];
}
