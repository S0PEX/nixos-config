#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# Specify the hostname for the configuration
# HOSTNAME="nixos"  # Change this if your hostname is different

echo "Building the NixOS configuration for $HOSTNAME..."

# Build the NixOS configuration
nix build .#nixosConfigurations.$HOSTNAME.config.system.build.toplevel

echo "Switching to the new configuration..."

# Switch to the new configuration
sudo nixos-rebuild switch --flake .

echo "NixOS configuration applied successfully!"
