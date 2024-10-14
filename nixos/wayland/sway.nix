{ config, pkgs, lib, ... }:

{
  # System-wide packages
  environment.systemPackages = with pkgs; [
    nwg-look # GTK theme manager for Sway
    nwg-displays # Manage displays for Sway
    grim # Screenshot functionality
    slurp # Selection tool for screenshots
    wl-clipboard # Clipboard utilities (wl-copy, wl-paste) for Wayland
    mako # Notification system (developed by SwayWM maintainer)
    fuzzel # Dmenu replacement for launching apps
    waybar # Status bar for Sway
  ];

  # Enable Sway window manager with GTK support
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # Fonts required by Waybar and other system components
  fonts.packages = with pkgs; [
    noto-fonts # General-purpose fonts
    noto-fonts-cjk # CJK fonts (Chinese, Japanese, Korean)
    noto-fonts-emoji # Emoji support
    liberation_ttf # Liberation fonts
    nerdfonts # Popular patched fonts with icons
    roboto-mono # Monospaced font (Roboto Mono)
    font-awesome # Icon font (Font Awesome)
  ];
}
