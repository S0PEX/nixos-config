{ config, pkgs, ... }:

let
  systemdTarget = "wayland-session@Hyprland.target";
in
{
  # Ensure kanshi is installed system-wide
  environment.systemPackages = with pkgs; [
    kanshi
  ];

  # Create a systemd user service for kanshi
  systemd.user.services.kanshi = {
    description = "Kanshi - Dynamic display configuration";

    after = [ systemdTarget ];
    partOf = [ systemdTarget ];
    wantedBy = [ systemdTarget ];

    unitConfig = {
      ConditionEnvironment = "WAYLAND_DISPLAY";
    };

    serviceConfig = {
      ExecStart = "${pkgs.kanshi}/bin/kanshi";
      Restart = "always";
      RestartSec = "10";
    };
  };
}
