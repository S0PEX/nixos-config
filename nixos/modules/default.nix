{ config, pkgs, ... }:

{
  imports = [
    ./fonts.nix
    ./kanshi.nix
    ./nvidia.nix
    ./services.nix
    ./virtualisation.nix
  ];
}
