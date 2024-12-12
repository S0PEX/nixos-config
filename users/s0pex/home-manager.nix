{ inputs, systemVersion, ... }:

{ config, pkgs, pkgs-unstable, ... }:

{
  # Home-manager 22.11 requires this be set. We never set it so we have
  # to use the old state version.
  home.stateVersion = systemVersion;

  # Stable user packages
  home.packages = with pkgs-unstable; [
    # Browsers
    brave

    # Terminal additions
    oh-my-fish

    # Dotfiles
    chezmoi # Dotfile manager

    # Communications
    discord # Discord chat client
    ferdium # Multi service chat client

    # Multimedia
    youtube-music

    # Writing tools and editors
    vscode # Visual Studio Code
    code-cursor # Cursor AI Editor
    texliveFull # Full TeX Live distribution

    # Programming languages and development tools
    go # Go programming language
    nodejs_20 # Node.js
    pnpm # Node.js package manager
    deno # Alternative JavaScript runtime
    nixpkgs-fmt # Formatter for Nix

    # Git clients
    gitkraken

    # Themes
    yaru-theme
  ];

  # Starship terminal extension
  programs.fish.enable = true; # Enable Fish shell to ensure compatibility
  programs.starship = {
    enable = true;
  };


  # Theme settings
  gtk = {
    enable = true;
    theme = {
      name = "Yaru-prussiangreen-dark";
      package = pkgs-unstable.yaru-theme;
    };

    # Prefer dark theme for both GTK3 and GTK4
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };
}
