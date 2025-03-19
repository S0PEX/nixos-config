{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Import the main system configuration
  imports = [
    ./system.nix # Main system configuration file
  ];
}
