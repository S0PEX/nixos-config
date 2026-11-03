{
  flake.nixosModules.desktop =
    { pkgs, ... }:
    {
      # Enable Hyprland
      programs.hyprland = {
        enable = true;

        # Use UWSM to handle systemd targets such as wayland-session and graphical-session
        withUWSM = true;
      };

      # Add default packages
      environment.systemPackages = with pkgs; [
        # Hyprland and dependencies
        awww # Wallpaper engine
        wayle # hyprpanel sucessor
        hypridle
        hyprlock

        # Wayland utilities
        kitty
        fuzzel
        nwg-look
        nwg-displays
        wl-clipboard

        # Screenshot tool
        grim
        slurp
        swappy
        satty
        flameshot
      ];

      # Set session variables
      environment.sessionVariables = {
        # Enable XDG portal support
        NIXOS_XDG_OPEN_USE_PORTAL = "1";
        # Hint electron apps to use wayland
        NIXOS_OZONE_WL = "1";
      };
    };
}
