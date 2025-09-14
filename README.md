# NixOS Flakes Personal Configuration

This repository contains my personal configuration for NixOS, using the Nix Flakes feature.

## Initial Setup

To get started with this configuration on a NixOS system, follow these steps:

1. Clone this repository to a folder of your choice, e.g., `~/nixos-config`:

   ```bash
   $ git clone https://github.com/S0PEX/nixos-config.git ~/nixos-config
   ```

2. Enable experimental Nix features, such as nix-command and flakes, by adding the following to your NixOS configuration:
   ```nix
   nix.settings.experimental-features = [ "nix-command" "flakes" ];
   ```
   Now you're ready to use Flakes to manage your NixOS setup!

## Usage

1. `cd` into the cloned `nixos-config` folder (e.g.):

   ```bash
   $ cd ~/nixos-config
   ```

2. Copy the default configuration and hardware configuration of your current build to the `/hardware/{systemName}` directory:

   ```bash
   $ sudo cp /etc/nixos/ ./hardware/{systemName}
   ```

   **Warning**: Make sure to rename your `hardware-configuration.nix` to something meaningful and update the `flake.nix` configuration accordingly.

   For example:

   ```nix
   # Define NixOS configurations
   # Usage of mkSystem: mkSystem "name of the hardware configuration file under hardware/"
   nixosConfigurations.nixos = mkSystem "${systemName}" {  # Binds hardware/${systemName}/ to this configuration
     user = "s0pex";  # Specifies the user for the configuration; this option is used to load the configs from users/${user}
   };
   ```

3. To apply the configuration, run the following commands:
   ```bash
   $ sudo nixos-rebuild switch --flake .
   ```
   
   **Warning**: Currently, this configuration assumes that your host is called `nixos`. If your system's hostname is different, make sure to specify `nixos` when running the flake commands or adjust the configuration accordingly.
