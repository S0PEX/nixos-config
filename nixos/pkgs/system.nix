{ config, pkgs, ... }:

{
  # Packages installed in system profile
  environment.systemPackages = with pkgs; [
    # Dotfiles
    git
    vim
    chezmoi

    # VPN
    openvpn3

    # Browsers
    librewolf
    firefox-bin
    microsoft-edge

    # Communication
    thunderbird-bin

    # Misc
    unzip
    nautilus
  ];
}
