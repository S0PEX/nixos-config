{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  name = "dev-shell";

  buildInputs = with pkgs; [
    statix
    treefmt
    pre-commit
    nixfmt-rfc-style
  ];

  shellHook = ''
    pre-commit install
  '';
}
