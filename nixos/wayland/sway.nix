{ config, pkgs, lib, ... }:

{
  # System-wide packages
  environment.systemPackages = with pkgs; [
    fuzzel # Dmenu replacement for launching apps
    grim # Screenshot functionality 
    mako # Notification system (developed by SwayWM maintainer)
    nwg-displays # Manage displays for Sway
    nwg-look # GTK theme manager for Sway
    slurp # Selection tool for screenshots
    waybar # Status bar for Sway
    wl-clipboard # Clipboard utilities (wl-copy, wl-paste) for Wayland
  ];

  # Enable Sway window manager with GTK support
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
}
