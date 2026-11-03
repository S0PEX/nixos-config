# Bundle: every virtualisation backend
{ self, ... }:
{
  flake.nixosModules.virtualisation.imports = with self.nixosModules; [
    virtualisation-libvirt
    virtualisation-docker
  ];
}
