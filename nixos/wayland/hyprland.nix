{ config, pkgs, ... }:

{
  # Enable Hyprland with XWayland support
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Enable XDG portal support
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
  ];

  # Add default packages
  environment.systemPackages = with pkgs; [
    mako # Notification system (developed by SwayWM maintainer)
    swww # Wallpaper utility
    waybar # Status bar for Sway
    fuzzel # Dmenu replacement for launching apps
    wlogout # Logout utility for Wayland
    wl-clipboard # Clipboard utilities (wl-copy, wl-paste) for Wayland
    nwg-displays # Manage displays for Wayland
    xwaylandvideobridge # XWayland video bridge

    kitty # Default Terminal emulator for Hyprland
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
