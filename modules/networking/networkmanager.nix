{
  flake.nixosModules.networking =
    { pkgs, ... }:
    {
      networking.networkmanager.plugins = [ pkgs.networkmanager-openvpn ];

      # Tray GUI (starts with the graphical session)
      programs.nm-applet.enable = true;
    };
}
