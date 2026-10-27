# Not in nixpkgs; wrap the upstream AppImage
{
  perSystem =
    { pkgs, ... }:
    let
      pname = "parallel-code";
      version = "5.0.0";
      src = pkgs.fetchurl {
        url = "https://github.com/johannesjo/parallel-code/releases/download/v${version}/Parallel-Code-${version}.AppImage";
        hash = "sha512-Jad9ztNVA+I7GNCQRO8h2eORkNry9AznYwisXkQSDxM6VHSgWysg0RELFM9n2L0Xw24rxrQQoYuJsu9hVunfMQ==";
      };
      contents = pkgs.appimageTools.extract { inherit pname version src; };
    in
    {
      packages.parallel-code = pkgs.appimageTools.wrapType2 {
        inherit pname version src;
        extraInstallCommands = ''
          install -Dm444 ${contents}/${pname}.desktop $out/share/applications/${pname}.desktop
          install -Dm444 ${contents}/usr/share/icons/hicolor/1024x1024/apps/${pname}.png \
            $out/share/icons/hicolor/1024x1024/apps/${pname}.png
          substituteInPlace $out/share/applications/${pname}.desktop \
            --replace-fail 'Exec=AppRun --no-sandbox' 'Exec=${pname} --no-sandbox' \
            --replace-fail 'Icon=${pname}' "Icon=$out/share/icons/hicolor/1024x1024/apps/${pname}.png"
        '';
      };
    };
}
