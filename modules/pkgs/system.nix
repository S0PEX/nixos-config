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

        # Communication
        thunderbird-bin

        # Media
        vlc
        qimgv

        # System utilities
        git
        vim
        bind
        htop
        ncdu
        unzip
        peazip
        ghostty
        ripgrep
        killall
        python3
        uv
        nautilus
        coreutils
        file-roller
        gnome-text-editor

        # NixOS related
        nixfmt
        nix-sweep
      ];
    };
}
