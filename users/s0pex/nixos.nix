{ pkgs, inputs, ... }:

{
  # Add ~/.local/bin to PATH
  environment.localBinInPath = true;

  # Configure user-specific settings
  users.users.s0pex = {
    isNormalUser = true; # Specify that this is a normal user
    description = "Artur"; # User description
    shell = pkgs.fish; # Set Fish as the user's shell
    extraGroups = [
      # Additional groups for the user
      "networkmanager"
      "wheel" # Allows the user to use sudo
      "docker" # Allows the user to use Docker
    ];
  };
}
