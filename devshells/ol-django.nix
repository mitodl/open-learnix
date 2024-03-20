{
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devenv.shells.ol-django = {
      packages = [pkgs.rye];
      languages.python = {
        enable = true;
        package = pkgs.python312;
      };
    };
  };
}
