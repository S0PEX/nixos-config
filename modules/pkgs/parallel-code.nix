# Not in nixpkgs; wrap the upstream AppImage
{
  perSystem =
    { pkgs, ... }:
    let
      pname = "parallel-code";
      version = "5.1.0";
      src = pkgs.fetchurl {
        url = "https://github.com/johannesjo/parallel-code/releases/download/v${version}/Parallel-Code-${version}.AppImage";
        hash = "sha512-u3XU0jUxJOhej6l5t28e1z6vMmrAke6nsH8rzP/ISTkWuE1SlMuqK7GQpF7vG4CvCe53f0ebxPJ6ciWW9/c/aQ==";
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
