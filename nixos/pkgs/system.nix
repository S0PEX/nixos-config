{ config, pkgs, lib, ... }:

{
  # System packages for Fish shell and related plugins
  environment.systemPackages = with pkgs; [
    firefox-bin # Firefox web browser
    librewolf # LibreWolf web browser
    git # Distributed version control system

    # Console utilities
    fishPlugins.done # Completion plugin for Fish
    fishPlugins.fzf-fish # Fuzzy finder integration for Fish
    fishPlugins.forgit # Plugin for managing forgotten commands
    fishPlugins.hydro # Hydration prompts for Fish
    fzf # Command-line fuzzy finder
    fishPlugins.grc # Colorized output for commands
    grc # Generalized colorizer

    # Terminals and terminal utilities
    kitty

    # System utilities
    xfce.thunar # File manager
  ];

  # System fonts for various applications
  fonts.packages = with pkgs; [
    noto-fonts # General-purpose fonts
    noto-fonts-cjk # CJK fonts (Chinese, Japanese, Korean)
    noto-fonts-emoji # Emoji support
    liberation_ttf # Liberation fonts
    nerdfonts # Popular patched fonts with icons
    roboto-mono # Monospaced font (Roboto Mono)
    font-awesome # Icon font (Font Awesome)
  ];

  # Enable Fish shell
  programs.fish.enable = true;
}
