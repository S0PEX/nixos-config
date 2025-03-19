{
  config,
  lib,
  pkgs,
  ...
}:

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

    # Fixes for VA-API with nvidia and other software that uses OpenGL
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia"; # Use nvidia driver for VAAPI
      GBM_BACKEND = "nvidia-drm"; # Use nvidia-drm backend for GBM
      __GLX_VENDOR_LIBRARY_NAME = "nvidia"; # Use nvidia GLX vendor library
    };
  };
}
