{ config, pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland = {
    enable = true;

    # Use UWSM to handle systemd targets such as wayland-session and graphical-session
    withUWSM = true;
  };

  # Add default packages
  environment.systemPackages = with pkgs; [
    kitty
    fuzzel
    hyprpanel
    nwg-look
    nwg-displays
  ];

  # Set session variables
  environment.sessionVariables = {
    # If cursor becomes invisible
    WLR_NO_HARDWARE_CURSORS = "1";
    # Enable XDG portal support
    NIXOS_XDG_OPEN_USE_PORTAL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };
}
