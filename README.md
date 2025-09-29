# NixOS Flake Configuration

This repository contains my personal, reproducible NixOS configuration using the Nix Flakes system.

## Getting Started

1. **Clone the repository:**

   ```shell
   $ git clone https://github.com/S0PEX/nixos-config.git ~/nixos-config
   Cloning into 'nixos-config'...
   remote: Enumerating objects: 189, done.
   remote: Counting objects: 100% (189/189), done.
   remote: Compressing objects: 100% (104/104), done.
   remote: Total 189 (delta 75), reused 178 (delta 64), pack-reused 0 (from 0)
   Receiving objects: 100% (189/189), 25.54 KiB | 6.38 MiB/s, done.
   Resolving deltas: 100% (75/75), done.
   $ cd ~/nixos-config
   ```

2. **Enable Flakes and nix-command:**

   Add this to your NixOS configuration (e.g., `/etc/nixos/configuration.nix`):

   ```nix
   nix.settings.experimental-features = [ "nix-command" "flakes" ];
   ```

   Then rebuild:

   ```shell
   $ sudo nixos-rebuild switch
   setting up /etc...
   ```

## Hardware Configuration

1. **Copy your hardware config:**

   ```bash
   # PWD is ~/nixos-config
   $ mkdir -p ./hardware/{systemName}/
   $ cp -r /etc/nixos/* ./hardware/{systemName}/
   ```

2. **Create system entry in `flake.nix`:**

   ```nix
   nixosConfigurations.{systemName} = mkSystem {
      user = "{username}";         # Username of the home manager config under users/{username}/
      systemName = "{systemName}"; # Must match your hardware folder name, e.g., ./hardware/{systemName}
   };
   ```

   Replace `{systemName}` with your actual system name and `{username}` with your actual username.  
   **Important:** The value of `systemName` in your flake must exactly match the directory name under `./hardware/{systemName}/`.

## Applying the Configuration

1. **Apply with the provided script:**

   ```bash
   ./scripts/apply.sh
   ```

   Or manually:

   ```bash
   sudo nixos-rebuild switch --flake .#{systemName}
   ```

---

For more details on NixOS flakes, see the [official documentation](https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake.html).
