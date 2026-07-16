{ lib, ... }:
{
  options.flake.nixHosts = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.deferredModule;
    default = { };
    description = "Raw, host-specific NixOS module fragments (hardware scans, per-machine tweaks), merged per hostname and spliced in automatically by mkSystem.";
  };
}
