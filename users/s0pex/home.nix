{
  config,
  pkgs,
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
  home.packages = with pkgs; [
    # Dotfiles
    chezmoi

    # Themes
    nordic

    # Development tools
    bruno
    vscode
    insomnia
    gitkraken
    jetbrains.goland
    jetbrains.datagrip
    jetbrains.idea-ultimate

    # Language runtimes and SDKs
    go
    bun
    gcc
    nodejs_22

    # Communications
    discord
    ferdium
    element-desktop

    # Others
    gimp3
    obs-studio
    texliveFull
    citrix_workspace
  ];

  # Java SDKs
  home.sessionPath = [ "$HOME/${jdksPath}" ];
  home.file = lib.listToAttrs (
    map (jdk: {
      name = "${jdksPath}/${jdk.version}";
      value.source = "${jdk}/lib/openjdk";
    }) additionalJDKs
  );

  # Shell
  programs = {
    direnv = {
      enable = true;
      silent = true; # Disable prologue message in shell
      nix-direnv.enable = true;
    };
    fish.enable = true;
    starship.enable = true;
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
  };
}
