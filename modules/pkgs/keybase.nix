{
  flake.homeModules.keybase =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.keybase-gui ];

      services.keybase.enable = true;
      services.kbfs.enable = true; # keybase-gui refuses to start without kbfsfuse
    };
}
