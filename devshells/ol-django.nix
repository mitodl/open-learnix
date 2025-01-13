{
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devenv.shells.ol-django = {
      packages = [pkgs.uv];
    };
  };
}
