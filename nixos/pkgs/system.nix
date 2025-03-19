{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:

{
  # System packages for Fish shell and related plugins
  environment.systemPackages =
    with pkgs;
    [
      firefox-bin
      librewolf
      git

      # Console utilities
      fishPlugins.done # Completion plugin for Fish
      fishPlugins.fzf-fish # Fuzzy finder integration for Fish
      fishPlugins.forgit # Plugin for managing forgotten commands
      fishPlugins.hydro # Hydration prompts for Fish
      fzf # Command-line fuzzy finder
      fishPlugins.grc # Colorized output for commands
      grc # Generalized colorizer
      direnv # Load and unload shell extensions

      # Terminals and terminal utilities
      kitty

      # System utilities
      htop
      killall
      python312

      lm_sensors # Hardware monitoring tool
      pulseaudio # PulseAudio sound server, we only use it for its ctl to interact with pipewire

      # Multimedia utilities
      vlc

      # Network shares
      cifs-utils
    ]
    ++ [ pkgs-unstable.ghostty ];

  # SSH Agent
  programs.ssh.startAgent = true;

  # Archive utility required for Thunar archive plugin
  programs.file-roller.enable = true;

  # Enable thunar plugins for archive and volume management
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-volman
      thunar-archive-plugin
    ];
  };

  # Enable GVFS: Mount, trash, and other functionalities
  services.gvfs.enable = true;

  # System fonts for various applications
  fonts.packages =
    with pkgs;
    [
      noto-fonts # General-purpose fonts
      noto-fonts-cjk-sans # CJK fonts (Chinese, Japanese, Korean)
      noto-fonts-emoji # Emoji support
      liberation_ttf # Liberation fonts
      nerdfonts # Popular patched fonts with icons
      roboto-mono # Monospaced font (Roboto Mono)
      font-awesome # Icon font (Font Awesome)
      source-code-pro # Monospaced font (Source Code Pro)
    ]
    ++ [ pkgs-unstable.nerd-fonts.jetbrains-mono ];

  # Enable Fish shell
  programs.fish.enable = true;

  # Enable Docker
  virtualisation.docker.enable = true;
}
