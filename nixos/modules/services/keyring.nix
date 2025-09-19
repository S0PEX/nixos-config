{ config, pkgs, ... }:

{
  # Keyring
  services = {
    gnome = {
      gnome-keyring.enable = true;
    };
    passSecretService.enable = true;
  };

  environment.systemPackages = with pkgs; [
    seahorse
    libsecret
  ];

  # Unlock Keyring on startup
  security = {
    pam = {
      services = {
        sddm.enableGnomeKeyring = true;
      };
    };
  };
}
