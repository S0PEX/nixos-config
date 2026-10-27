# Not in nixpkgs (nixpkgs `orca` is the screen reader); wrap the upstream AppImage
{
  perSystem =
    { pkgs, ... }:
    let
      pname = "orca-ide";
      version = "1.4.242";
      src = pkgs.fetchurl {
        url = "https://github.com/stablyai/orca/releases/download/v${version}/orca-linux.AppImage";
        hash = "sha256-VqRIL+PSPtqCFioJ2DWkDIJPdxUAUngdSz14S5Ua5BE=";
      };
      contents = pkgs.appimageTools.extract { inherit pname version src; };
    in
    {
      packages.orca = pkgs.appimageTools.wrapType2 {
        inherit pname version src;
        extraInstallCommands = ''
          install -Dm444 ${contents}/${pname}.desktop $out/share/applications/${pname}.desktop
          install -Dm444 ${contents}/usr/share/icons/hicolor/512x512/apps/${pname}.png \
            $out/share/icons/hicolor/512x512/apps/${pname}.png
          substituteInPlace $out/share/applications/${pname}.desktop \
            --replace-fail 'Exec=AppRun' 'Exec=${pname} --no-sandbox'
        '';
      };
    };
}
