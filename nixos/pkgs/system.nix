{ config, pkgs, ... }:

{
  # Packages installed in system profile
  environment.systemPackages = with pkgs; [
    # Browsers
    brave
    firefox-bin

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
    git
    vim
    bind
    htop
    ncdu
    unzip
    peazip
    ghostty
    ripgrep
    killall
    python3
    nautilus
    coreutils
    file-roller
    gnome-text-editor

    # NixOS related
    nixfmt
    nix-sweep
  ];
}
