{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:

let
  # Java SDKs
  jdksPath = ".jdks"; # IntelliJ's default path for Java SDKs
  additionalJDKs = with pkgs; [
    jdk11
    jdk21
  ];
in
{
  # Packages
  home.packages = with pkgs-unstable; [
    # Dotfiles
    chezmoi

    # Themes
    nordic

    # Development tools
    direnv
    vscode
    insomnia
    gitkraken
    # citrix_workspace
    jetbrains.goland
    jetbrains.datagrip
    jetbrains.idea-ultimate

    # Language runtimes and SDKs
    go
    bun
    nodejs_22

    # Communications
    discord
    ferdium
    element-desktop

    # Security
    veracrypt
  ];

  # Java SDKs
  home.sessionPath = [ "$HOME/${jdksPath}" ];
  home.file = lib.listToAttrs (
    map (jdk: {
      name = "${jdksPath}/${jdk.version}";
      value.source = "${jdk}/lib/openjdk";
    }) additionalJDKs
  );

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
