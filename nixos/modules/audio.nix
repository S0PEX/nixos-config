{ config, pkgs, ... }:

{
  # Enable RTKit for real-time scheduling (optional but recommended)
  security.rtkit.enable = true;

  # Enable PipeWire for audio management
  sound.enable = false; # Disable the default sound management

  services.pipewire = {
    enable = true; # Enable PipeWire service
    wireplumber.enable = true; # Enable WirePlumber service
    alsa.enable = true; # Enable ALSA support
    alsa.support32Bit = true; # Support 32-bit ALSA applications
    pulse.enable = true; # Enable PulseAudio compatibility layer
  };
}
