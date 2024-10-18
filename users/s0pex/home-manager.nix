{ inputs, ... }:

{ config, pkgs, pkgs-unstable, ... }:

{
  # Home-manager 22.11 requires this be set. We never set it so we have
  # to use the old state version.
  home.stateVersion = "24.05";

  # User packages
  home.packages = with pkgs; [
    pkgs-unstable.zed-editor

    # Terminal additions
    oh-my-fish

    # Dotfiles
    chezmoi # Dotfile manager

    # Communications
    discord # Discord chat client
    ferdium # Multi service chat client

    # Writing tools
    texliveFull # Full TeX Live distribution

    # IDEs
    vscode # Visual Studio Code
    jetbrains.goland # GoLand IDE
    jetbrains.idea-ultimate # IntelliJ IDEA
    jetbrains.pycharm-professional # PyCharm
    jetbrains.datagrip # DataGrip

    # Formatter for Nix
    nixpkgs-fmt

    # Programming languages
    go # Go programming language
    nodejs_20 # Node.js

    # Git clients
    gitkraken
  ];

  # Theme settings
  gtk = {
    enable = true;
    theme = {
      name = "Yaru-prussiangreen-dark";
      package = pkgs.yaru-theme;
    };

    # Prefer dark theme
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };
}
