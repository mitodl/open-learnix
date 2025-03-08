{
  perSystem = {
    config,
    pkgs,
    pkgs-unstable,
    ...
  }: {
    devenv.shells.ol-django = {
      packages = [
        pkgs-unstable.uv
      ];

      env = {
        LD_LIBRARY_PATH = "{pkgs.xmlsec}/lib:$LD_LIBRARY_PATH";
      };
    };
  };
}
