{
  flake.nixosModules.networking.networking.networkmanager.enable = true;

  # Tray GUI (starts with the graphical session)
  flake.nixosModules.desktop.programs.nm-applet.enable = true;
}
