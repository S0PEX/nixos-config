{ config, pkgs, ... }:

{
  # Enable Hyprland with XWayland support
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

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

    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };
}
