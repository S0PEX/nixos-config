{ config, pkgs, ... }:

{
  networking.nameservers = [
    "1.1.1.1" # Cloudflare
    "1.0.0.1" # Cloudflare
    "8.8.8.8" # Google
    "8.8.4.4" # Google
  ];
}
