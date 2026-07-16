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

This repo follows the [dendritic pattern](https://github.com/mightyiam/dendritic): every file under `modules/` is auto-imported via `import-tree`, and each feature module registers itself as a named `flake.nixosModules.<name>` (files under a shared folder like `modules/services/` merge into one `nixosModules.services`, while `modules/hardware/` keeps each file's module separately addressable, e.g. `nixosModules.bluetooth`).

Host-specific, non-reusable NixOS fragments (hardware scans, machine tweaks) and per-user fragments (account definition, home-manager config) can't be plain top-level modules — `import-tree` would try to evaluate them as flake-parts modules directly and choke on NixOS-only special args like `modulesPath`. Instead they're declared under two custom flake options (`modules/nixHosts.nix` / `modules/nixUsers.nix`), typed the same way flake-parts types its own `nixosModules` option (`lazyAttrsOf deferredModule`), which merges same-named contributions without ever evaluating them prematurely:

- `flake.nixHosts.<hostname>` — every file under `modules/hosts/<hostname>/` (besides `default.nix`) contributes to this and gets merged; `mkSystem` splices `self.nixHosts.${systemName}` into every host automatically.
- `flake.nixUsers.<username>` — every file under `modules/users/<username>/` contributes to this; a host opts a user in explicitly, e.g. `self.nixUsers.s0pex` in its `modules` list.

1. **Copy your hardware config:**

   ```bash
   # PWD is ~/nixos-config
   $ mkdir -p ./modules/hosts/{systemName}/
   $ cp /etc/nixos/hardware-configuration.nix ./modules/hosts/{systemName}/hardware-configuration.nix
   $ cp /etc/nixos/configuration.nix ./modules/hosts/{systemName}/configuration.nix
   ```

   Wrap each copied file's body as a `flake.nixHosts.{systemName}` contribution (see `modules/hosts/um790/hardware-configuration.nix` for a worked example) — the body itself stays otherwise unchanged.

2. **Create the host entry at `modules/hosts/{systemName}/default.nix`:**

   ```nix
   { inputs, self, ... }:
   let
     mkSystem = import ../../../lib/mkSystem.nix { inherit inputs; };
   in
   {
     flake.nixosConfigurations.{systemName} = mkSystem {
        inherit self;
        system = "x86_64-linux";
        systemName = "{systemName}";  # Must match this host's folder name, e.g. ./modules/hosts/{systemName}
        modules = [
          self.nixosModules.services  # pick whichever shared feature modules this host wants
          self.nixosModules.config
          self.nixosModules.desktop
          self.nixosModules.pkgs
          self.nixUsers.{username}    # enable whichever user(s) this host has
        ];
     };
   }
   ```

   Replace `{systemName}` with your actual system name and `{username}` with your actual username.  
   **Important:** The value of `systemName` must exactly match the directory name under `./modules/hosts/{systemName}/`. `hardware-configuration.nix`/`configuration.nix` don't need to be listed in `modules` — `mkSystem` wires in `self.nixHosts.{systemName}` for every host automatically.

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
