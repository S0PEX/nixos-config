{ config, pkgs, ... }:

{
  networking.nameservers = [
    "1.1.1.1" # Cloudflare DNS
  ];
}
