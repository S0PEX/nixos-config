# Bundle for machines with a graphical desktop (includes base)
{ self, ... }:
{
  flake.nixosModules.workstation.imports = with self.nixosModules; [
    base
    desktop
    services
    pkgs
  ];
}
