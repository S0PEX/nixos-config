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

This repo follows the [dendritic pattern](https://github.com/mightyiam/dendritic): every file under `modules/` is a flake-parts module, auto-imported via `import-tree`. Each file contributes to a named `flake.nixosModules.<name>` (or `flake.homeModules.<name>` for Home Manager). Files sharing a name are merged, so everything under `modules/services/` becomes one `nixosModules.services`.

Hosts, users and features are told apart by folder and name:

- `modules/hosts/<host>/` — `nixosModules.host-<host>` (hardware scan, machine tweaks) plus `default.nix`, which builds `nixosConfigurations.<host>`.
- `modules/users/<user>/` — `nixosModules.user-<user>` (account) and `homeModules.<user>` (Home Manager config). A user with a home config imports `nixosModules.home-manager` itself, so hosts without such users never load Home Manager.
- Per-user Home Manager parts live next to the user (`users/<user>/*.nix` merge into `homeModules.<user>`); optional ones get their own name (e.g. `homeModules.s0pex-programming`) and are imported explicitly in `user-<user>`. Shared Home Manager modules such as `homeModules.theme-nordic` (`modules/themes/`) and `homeModules.shell-fish` (`modules/shell/`) are imported the same way.
- Everything else — reusable NixOS feature modules (`desktop`, `services`, `bluetooth`, ...). Two bundles group the common ones: `base` (`cli`, `config`, `networking`, `kernel`; every host) and `workstation` (`base` + `desktop`, `services`, `pkgs`; graphical machines). A desktop host lists `workstation`, a headless one `base`. Opt-in extras within a domain share its prefix, e.g. `networking-openvpn`, `networking-cloudflare-google-dns`. A file may contribute to several modules, e.g. `networking/networkmanager.nix` enables NetworkManager in `networking` and its tray applet in `desktop`.

1. **Copy your hardware config:**

   ```bash
   # PWD is ~/nixos-config
   $ mkdir -p ./modules/hosts/{host}/
   $ cp /etc/nixos/hardware-configuration.nix ./modules/hosts/{host}/hardware-configuration.nix
   $ cp /etc/nixos/configuration.nix ./modules/hosts/{host}/configuration.nix
   ```

   Wrap each copied file's body as a `flake.nixosModules.host-{host}` contribution (see `modules/hosts/um790/hardware-configuration.nix`), and set `networking.hostName = "{host}";` in it.

2. **Create the host entry at `modules/hosts/{host}/default.nix`:**

   ```nix
   { inputs, self, ... }:
   {
     flake.nixosConfigurations.{host} = inputs.nixpkgs.lib.nixosSystem {
       modules = with self.nixosModules; [
         # Host and user
         host-{host}
         user-{user}

         # Bundles
         workstation  # use `base` instead on headless machines

         # Extra features
         bluetooth
       ];
     };
   }
   ```

## Applying the Configuration

1. **Apply with the provided script:**

   ```bash
   ./scripts/apply.sh
   ```

   Or manually:

   ```bash
   sudo nixos-rebuild switch --flake .#{host}
   ```

---

For more details on NixOS flakes, see the [official documentation](https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake.html).
