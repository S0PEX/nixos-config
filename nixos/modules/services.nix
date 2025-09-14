{ config, pkgs, ... }:

{
  # Keyring
  programs.seahorse.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.passSecretService.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true; # Unlock Keyring on start
  environment.systemPackages = with pkgs; [
    libsecret
  ];

  # SSH Agent
  programs.ssh.startAgent = true;
}
