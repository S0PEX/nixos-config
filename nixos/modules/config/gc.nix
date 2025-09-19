{ config, pkgs, ... }:

{
  # Enable garbage collection for configurations that are older than three days
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep-since 3d --keep 2";
    };
  };

  # Enable periodic optimisation of the nix store
  nix.optimise.automatic = true;
}
