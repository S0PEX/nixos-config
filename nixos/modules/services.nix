{ config, pkgs, ... }:

{
  # SSH Agent
  programs.ssh.startAgent = true;

  # GVFS for virtual filesystem access (e.g. smb, trash, mtp)
  services.gvfs = {
    enable = true;
  };

  # Keyring
  services = {
    gnome.gnome-keyring.enable = true;
    passSecretService.enable = true;
  };
  programs.seahorse.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true; # Unlock Keyring on start
  environment.systemPackages = with pkgs; [
    libsecret
  ];
}
