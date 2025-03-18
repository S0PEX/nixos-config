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
    discord
    ferdium # Multi service chat client
    thunderbird-bin

    # Multimedia
    youtube-music
    obs-studio

    # Writing tools and editors
    vscode
    obsidian
    code-cursor
    texliveFull

    # Development tools
    gitkraken
    jetbrains.goland
    citrix_workspace

    # Programming languages and runtimes
    go
    jdk
    graphviz # Required for PlantUML
    bun # Alternative JavaScript runtime
    deno # Alternative JavaScript runtime
    pnpm
    nodejs_22
    nixfmt # Formatter for Nix
  ];

  # Terminal extension
  programs.fish.enable = true;
  programs.starship = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };

  # Default applications
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "librewolf.desktop";
      "text/xml" = "librewolf.desktop";
      "application/xhtml+xml" = "librewolf.desktop";
      "x-scheme-handler/ftp" = "librewolf.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
    };
  };

  # Theme settings
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true; # Hyprland is falling back to X11's XCURSOR_THEME, if HYPRCURSOR_THEME is not set. When not set, cursor theme is not constantly applied to all applications
    package = pkgs.bibata-cursors;
    name = "Bibata-Original-Classic";
    size = 22;
  };

  gtk = {
    enable = true;

    theme = {
      name = "Juno-ocean";
      package = pkgs-unstable.juno-theme;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs-unstable.papirus-icon-theme;
    };

    # Prefer dark theme for both GTK3 and GTK4
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };
}
