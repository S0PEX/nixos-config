# Command-line tools every host gets (imported by base)
{
  flake.nixosModules.cli =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        git
        vim
        bind
        htop
        ncdu
        unzip
        ripgrep
        killall
        nixfmt
        nix-sweep
      ];
    };
}
