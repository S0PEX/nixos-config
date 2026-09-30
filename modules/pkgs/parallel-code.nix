# Not in nixpkgs; wrap the upstream AppImage
{
  perSystem =
    { pkgs, ... }:
    let
      pname = "parallel-code";
      version = "3.1.0";
      src = pkgs.fetchurl {
        url = "https://github.com/johannesjo/parallel-code/releases/download/v${version}/Parallel-Code-${version}.AppImage";
        hash = "sha512-fNu55dEJrMNhjn3cQKjMVwQuggH7GPywdt+ff2j63zpRoHtxW0lYtowwNdpwu1kQd4VA9uNMZ8ov2hXRubSfZg==";
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
