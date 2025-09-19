{ systemVersion, ... }:

{
  config,
  pkgs,
  ...
}:

{
  # Home-manager requires this be explicitly set
  home.stateVersion = systemVersion;

  # Packages
  home.packages = with pkgs; [
    # Dotfiles
    chezmoi

    # Themes
    nordic

    # Development tools
    direnv
    vscode
    insomnia
    gitkraken
    citrix_workspace
    jetbrains.goland
    jetbrains.idea-ultimate

    # Language runtimes and SDKs
    go
    bun
    nodejs_22
    jdk21

    # Communications
    discord
    ferdium
    element-desktop

    # Security
    veracrypt
  ];

  programs = {
    # Terminal extensions
    fish.enable = true;
    starship.enable = true;
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
  };
}
