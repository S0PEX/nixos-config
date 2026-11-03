{
  flake.nixosModules.host-um790 =
    { pkgs, ... }:
    {
      networking.hostName = "um790";

      # Bootloader.
      boot.loader.systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      boot.loader.efi.canTouchEfiVariables = true;

      # Use latest kernel.
      boot.kernelPackages = pkgs.linuxPackages_latest;

      # Enable CUPS to print documents.
      services.printing.enable = true;

      # Enable sound with pipewire.
      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      system.stateVersion = "25.05";
    };
}
