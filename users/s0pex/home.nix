{
  config,
  pkgs,
  pkgs-stable,
  lib,
  ...
}:

let
  # Java SDKs
  jdksPath = ".jdks"; # IntelliJ's default path for Java SDKs
  additionalJDKs = with pkgs; [
    jdk11
    jdk17
    jdk21
    jdk25
  ];
in
{
  # Packages
  home.packages = with pkgs; [
    # VPN
    eddie

    # Dotfiles
    chezmoi

    # Browsers
    microsoft-edge
    mullvad-browser

    # Themes
    nordic

    # Development tools
    bruno
    devenv
    vscode
    rpi-imager
    gitkraken

    jetbrains.idea
    jetbrains.datagrip
    jetbrains.phpstorm
    # jetbrains.clion

    # Language runtimes and SDKs
    gcc
    nodejs_24

    # Communications
    discord
    ferdium

    # Writing
    zotero
    diffpdf

    # Others
    gimp
    obs-studio
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

    # K8s monitoring
    k9s.enable = true;
  };
}
