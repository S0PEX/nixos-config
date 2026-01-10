{ config, pkgs, ... }:

{
  # Packages installed in system profile
  environment.systemPackages = with pkgs; [
    # Browsers
    brave
    firefox-bin
    microsoft-edge

    # Office
    sioyek
    papers
    pdfarranger
    libreoffice-fresh

    # Communication
    thunderbird-bin

    # Media
    vlc

    # System utilities
    jq
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
    nixfmt
  ];
}
