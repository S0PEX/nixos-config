{
  flake.nixosModules.pkgs =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # Spell-check dictionaries (picked up via XDG_DATA_DIRS by Thunderbird/Firefox)
        hunspellDicts.de_DE

        # Hyphenation dictionaries (picked up via DICPATH by the libreoffice wrapper)
        hyphenDicts.de_DE
        hyphenDicts.en_US
      ];
    };
}
