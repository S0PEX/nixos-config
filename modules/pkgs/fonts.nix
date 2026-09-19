{
  flake.nixosModules.pkgs =
    { pkgs, ... }:
    {
      # System fonts for various applications
      fonts.packages = with pkgs; [
        inter # Professional UI/email sans-serif (Segoe UI-like)
        noto-fonts # General-purpose fonts
        noto-fonts-cjk-sans # CJK fonts (Chinese, Japanese, Korean)
        noto-fonts-color-emoji # Emoji support
        liberation_ttf # Liberation fonts
        roboto-mono # Monospaced font (Roboto Mono)
        font-awesome # Icon font (Font Awesome)
        source-code-pro # Monospaced font (Source Code Pro)
        nerd-fonts.jetbrains-mono # Nerd Font (JetBrains Mono)
      ];
    };
}
