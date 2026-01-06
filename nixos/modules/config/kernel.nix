{
  lib,
  config,
  pkgs,
  ...
}:

{
  # Allow perf as user
  boot.kernel.sysctl."kernel.perf_event_paranoid" = lib.mkForce 1;
  boot.kernel.sysctl."kernel.kptr_restrict" = lib.mkForce 0;
}
