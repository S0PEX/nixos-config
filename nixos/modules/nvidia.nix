{ config, lib, pkgs, ... }:

{
  # Create option to conditionally enable this module
  options.hardware.nvidia = {
    enable = lib.mkEnableOption "nvidia driver";
  };

  config = lib.mkIf config.hardware.nvidia.enable {
    # Enable graphics
    hardware.graphics.enable = true;

    # Load nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      # Modesetting is required for Wayland
      modesetting.enable = true;

      powerManagement = {
        # Enable if experiencing graphical corruption after suspend/resume
        # Saves entire VRAM to /tmp/ instead of essentials
        enable = false;

        # Experimental power saving for Turing+ GPUs
        finegrained = false;
      };

      # Open source kernel module (Turing+ only, alpha quality)
      open = false;

      # Nvidia control panel
      nvidiaSettings = false;

      # Default to stable driver version
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
