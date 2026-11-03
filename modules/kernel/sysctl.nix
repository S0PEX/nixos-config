{
  flake.nixosModules.kernel = {
    boot.kernel.sysctl = {
      # Increase inotify watches limit to allow IDEs to watch more files
      "fs.inotify.max_user_watches" = 1048576;

      # Allow perf as user
      "kernel.perf_event_paranoid" = 1;
      "kernel.kptr_restrict" = 0;
    };
  };
}
