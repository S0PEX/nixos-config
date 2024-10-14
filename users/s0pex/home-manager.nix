{ inputs, ... }:

{ config, pkgs, ... }:

{
  # Home-manager 22.11 requires this be set. We never set it so we have
  # to use the old state version.
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    # Dotfiles
    chezmoi # Dotfile manager

    # Communications
    discord # Discord chat client

    # Git clients
    gitkraken

    # IDEs
    vscode # Visual Studio Code
    #jetbrains.goland         # GoLand IDE
    #jetbrains.idea-ultimate  # IntelliJ IDEA
    #jetbrains.pycharm-professional        # PyCharm
    #jetbrains.datagrip       # DataGrip

    # Formatter for Nix
    nixpkgs-fmt
  ];

  # Theme settings
  gtk = {
    enable = true;
    theme = {
      name = "Yaru-prussiangreen-dark";
      package = pkgs.yaru-theme;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
}
