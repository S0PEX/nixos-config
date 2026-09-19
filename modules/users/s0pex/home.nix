{
  flake.nixUsers.s0pex = {
    home-manager.users.s0pex.imports = [
      (
        {
          inputs,
          config,
          pkgs,
          pkgs-stable,
          lib,
          ...
        }:

        let
          # Java SDKs
          jdksPath = ".jdks"; # IntelliJ's default path for Java SDKs
          additionalJDKs = with pkgs; [
            jdk17
            jdk21
            jdk25
          ];
        in
        {
          # Packages
          home.packages = with pkgs; [
            basicswap
            monero-gui

            # VPN
            eddie

            # Dotfiles
            chezmoi

            # Browsers
            microsoft-edge
            mullvad-browser
            inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default

            # AI Agents
            claude-code

            # Development tools
            bruno
            devenv
            vscode
            rpi-imager
            gitkraken

            jetbrains.idea
            jetbrains.datagrip
            jetbrains.phpstorm
            jetbrains.rust-rover

            # Language runtimes and SDKs
            gcc
            nodejs_24

            # Rust tools
            cargo
            rustc

            # Communications
            discord
            ferdium
            teams-for-linux

            # Writing
            zotero
            diffpdf
            obsidian

            # Others
            gimp
            krita
            portfolio
            obs-studio
          ];

          # Java SDKs
          home.sessionPath = [ "$HOME/${jdksPath}" ];
          home.file = lib.listToAttrs (
            map (jdk: {
              name = "${jdksPath}/${jdk.version}";
              value.source = "${jdk}/lib/openjdk";
            }) additionalJDKs
          );

          # Shell
          programs = {
            direnv = {
              enable = true;
              silent = true; # Disable prologue message in shell
              nix-direnv.enable = true;
            };
            fish.enable = true;
            starship.enable = true;
            zoxide = {
              enable = true;
              enableBashIntegration = true;
              enableFishIntegration = true;
            };

            # K8s monitoring
            k9s.enable = true;
          };

          gtk = {
            enable = true;
            theme = {
              package = pkgs-stable.nordic;
              name = "Nordic";
            };
            iconTheme = {
              package = pkgs.nordzy-icon-theme;
              name = "Nordzy";
            };
            # Silence home-manager warning; keep GTK4 apps themed like GTK3 ones
            gtk4.theme = config.gtk.theme;
          };
        }
      )
    ];
  };
}
