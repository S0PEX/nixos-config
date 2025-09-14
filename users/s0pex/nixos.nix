{ config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.s0pex = {
    isNormalUser = true;
    description = "Artur";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];

    packages = with pkgs; [ ];
  };
}
