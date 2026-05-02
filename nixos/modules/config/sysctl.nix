{
  lib,
  config,
  pkgs,
  ...
}:

{
  boot.kernel.sysctl = {
    # Increase inotify watches limit to allow IDEs to watch more files
    "fs.inotify.max_user_watches" = 2 * 1024 * 1024 * 1024 - 1;

    # Allow perf as user
    "kernel.perf_event_paranoid" = 1;
    "kernel.kptr_restrict" = 0;
  };
}
