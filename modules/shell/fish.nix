# fish with starship prompt, zoxide and direnv
{
  flake.homeModules.shell-fish = {
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
  };
}
