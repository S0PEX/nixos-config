{ config, pkgs, ... }:

{
  # Packages installed in system profile
  environment.systemPackages = with pkgs; [
    # Browsers
    brave
    firefox-bin
    librewolf-bin
    microsoft-edge

    # Office
    libreoffice-fresh

    # Communication
    thunderbird-bin

    # Media
    vlc

    # System utilities
    git
    vim
    bind
    unzip
    ghostty
    python3
    nautilus
    coreutils
    gnome-text-editor

    # Formatting tools
    nixfmt-rfc-style
  ];
}
