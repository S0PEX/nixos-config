{ lib, ... }:
{
  options.flake.nixUsers = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.deferredModule;
    default = { };
    description = "Per-user NixOS account + home-manager module fragments, merged per username and enabled explicitly by a host.";
  };
}
