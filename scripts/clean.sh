#!/usr/bin/env bash

sudo nh clean all --keep-since 3d --keep 2
sudo nix-store --optimise
