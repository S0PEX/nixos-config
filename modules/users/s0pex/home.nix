{ inputs, ... }:
{
  flake.homeModules.s0pex =
    { pkgs, ... }:
    let
      inherit (pkgs.stdenv.hostPlatform) system;
    in
    {
      # Packages
      home.packages = with pkgs; [
        basicswap
        monero-gui

        # Dotfiles
        chezmoi

        # Passwords
        keepassxc

        # Browsers
        microsoft-edge
        mullvad-browser
        inputs.zen-browser.packages.${system}.default

        # Communications
        discord
        ferdium
        teams-for-linux

        # Writing
        diffpdf
        obsidian

        # Others
        gimp
        krita
        portfolio
        obs-studio
      ];
    };
}
