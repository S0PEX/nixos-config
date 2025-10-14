{ config, pkgs, ... }:

{
  # Packages installed in system profile
  environment.systemPackages = with pkgs; [
    # Browsers
    librewolf
    firefox-bin
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
    nautilus
    coreutils
    gnome-text-editor
  ];
}
