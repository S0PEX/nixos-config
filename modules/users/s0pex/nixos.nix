{ self, ... }:
{
  flake.nixosModules.user-s0pex = {
    imports = [ self.nixosModules.home-manager ];

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.s0pex = {
      isNormalUser = true;
      description = "Artur";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
        "libvirtd"
      ];
    };

    home-manager.users.s0pex.imports = with self.homeModules; [
      s0pex
      s0pex-programming
      shell-fish
      theme-nordic
    ];
  };
}
