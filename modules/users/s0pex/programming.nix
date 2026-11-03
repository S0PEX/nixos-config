# Programming setup for s0pex: tools, IDEs, SDKs
{ self, ... }:
{
  flake.homeModules.s0pex-programming =
    { pkgs, lib, ... }:
    let
      inherit (pkgs.stdenv.hostPlatform) system;

      # JDKs exposed under ~/.jdks, IntelliJ's default lookup path for Java SDKs
      jdksPath = ".jdks";
      jdks = with pkgs; [
        jdk17
        jdk21
        jdk25
      ];
    in
    {
      home.packages = with pkgs; [
        # AI Agents
        claude-code
        self.packages.${system}.orca
        self.packages.${system}.parallel-code

        # Development tools
        bruno
        devenv
        vscode
        teleport
        glab
        gitkraken

        jetbrains.idea
        jetbrains.datagrip
        jetbrains.phpstorm
        jetbrains.rust-rover

        # Language runtimes and SDKs
        gcc
        nodejs_24

        # Rust tools
        cargo
        rustc
      ];

      home.sessionPath = [ "$HOME/${jdksPath}" ];
      home.file = lib.listToAttrs (
        map (jdk: {
          name = "${jdksPath}/${jdk.version}";
          value.source = "${jdk}/lib/openjdk";
        }) jdks
      );

      # K8s monitoring
      programs.k9s.enable = true;
    };
}
