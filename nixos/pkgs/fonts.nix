{ config, pkgs, ... }:

{
  # System fonts for various applications
  fonts.packages = with pkgs; [
    noto-fonts # General-purpose fonts
    noto-fonts-cjk-sans # CJK fonts (Chinese, Japanese, Korean)
    noto-fonts-emoji # Emoji support
    liberation_ttf # Liberation fonts
    roboto-mono # Monospaced font (Roboto Mono)
    font-awesome # Icon font (Font Awesome)
    source-code-pro # Monospaced font (Source Code Pro)
    nerd-fonts.jetbrains-mono # Nerd Font (JetBrains Mono)
  ];
}
