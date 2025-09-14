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
    # eddie
    veracrypt

    # Other
    ghostty
  ];

  # Terminal extensions
  programs.fish.enable = true;
  programs.starship.enable = true;
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };
}
