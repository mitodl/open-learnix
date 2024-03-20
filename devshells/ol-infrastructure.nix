{
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devenv.shells.ol-infrastructure = {
      languages.python = {
        enable = true;
        package = pkgs.python312;
        poetry = {
          enable = true;
          activate.enable = true;
          install.enable = true;
        };
      };
    };
  };
}
