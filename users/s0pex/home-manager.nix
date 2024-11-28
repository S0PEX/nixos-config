{ inputs, ... }:

{ config, pkgs, pkgs-unstable, ... }:

{
  # Home-manager 22.11 requires this be set. We never set it so we have
  # to use the old state version.
  home.stateVersion = "24.05";

  # Stable user packages
  home.packages = with pkgs-unstable; [
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

    # IDEs
    #jetbrains.goland # GoLand IDE
    #jetbrains.idea-ultimate # IntelliJ IDEA
    #jetbrains.pycharm-professional # PyCharm
    #jetbrains.datagrip # DataGrip

    # Programming languages
    go # Go programming language
    nodejs_20 # Node.js
    pnpm # Node.js package manager
    deno # Alternative JavaScript runtime

    # Formatter for Nix
    nixpkgs-fmt

    # Git clients
    gitkraken

    # Themes
    yaru-theme
  ];

  # Theme settings
  gtk = {
    enable = true;
    theme = {
      name = "Yaru-prussiangreen-dark";
      package = pkgs-unstable.yaru-theme;
    };

    # Prefer dark theme
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };
}
