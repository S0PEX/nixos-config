# Nordic GTK theme with Nordzy icons
{
  flake.homeModules.theme-nordic =
    { config, pkgs, ... }:
    {
      gtk = {
        enable = true;
        theme = {
          package = pkgs.nordic;
          name = "Nordic";
        };
        iconTheme = {
          package = pkgs.nordzy-icon-theme;
          name = "Nordzy";
        };
        # Silence home-manager warning; keep GTK4 apps themed like GTK3 ones
        gtk4.theme = config.gtk.theme;
      };
    };
}
