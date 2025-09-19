{ config, pkgs, ... }:

{
  # Packages installed in system profile
  environment.systemPackages = with pkgs; [
    # Browsers
    librewolf
    firefox-bin
    microsoft-edge

    # Communication
    thunderbird-bin

    # System utilities
    git
    vim
    bind
    unzip
    ghostty
    nautilus
  ];
}
