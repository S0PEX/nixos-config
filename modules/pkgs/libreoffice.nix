{
  flake.nixosModules.pkgs =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        libreoffice-fresh

        # Hyphenation dictionaries (picked up via DICPATH by the libreoffice wrapper)
        hyphenDicts.de_DE
        hyphenDicts.en_US
      ];
    };
}
