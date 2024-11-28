{ config, pkgs, ... }:

{
  # Enable RTKit for real-time scheduling (optional but recommended)
  security.rtkit.enable = true;

  # Enable PipeWire for audio management
  sound.enable = false; # Disable the default sound management

  # Configure PipeWire with all common features enabled
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true; # Support 32-bit ALSA applications
    };
    pulse.enable = true; # Enable PulseAudio compatibility
    wireplumber.enable = true; # Enable wireplumber service
  };
}
