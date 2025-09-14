#!/usr/bin/env bash

# Clean up the Nix store and optimise it
sudo nh clean all
sudo nix-store --optimise
