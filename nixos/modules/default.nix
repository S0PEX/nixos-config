{ config, pkgs, ... }:

{
  imports = [
    ./fonts.nix
    ./nvidia.nix
    ./services.nix
    ./virtualisation.nix
  ];
}
