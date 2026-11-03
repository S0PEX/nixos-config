{
  flake.nixosModules.pkgs =
    { pkgs, ... }:
    {
      # Packages installed in system profile
      environment.systemPackages = with pkgs; [
        # Browsers
        brave
        firefox-bin

        # Office
        sioyek
        papers
        pdfarranger
        libreoffice-stable

        # Communication
        thunderbird-bin

        # Media
        vlc
        qimgv

        # System utilities
        peazip
        ghostty
        python3
        uv
        nautilus
        file-roller
        gnome-text-editor
      ];
    };
}
