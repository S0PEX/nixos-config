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
    waybar # Status bar for Sway
    swww # Wallpaper utility
    kitty # Default Terminal emulator for Hyprland
    fuzzel # Dmenu replacement for launching apps
    nwg-displays # Manage displays for Wayland
  ];

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
