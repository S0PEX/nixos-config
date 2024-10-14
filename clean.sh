#!/usr/bin/env bash

# Clean up the Nix store and optimise it
sudo nix-store --gc
sudo nix-collect-garbage -d
sudo nix-collect-garbage --delete-old
sudo nix store optimise

# Ensure that the NixOS configuration is up-to-date
./sync.sh