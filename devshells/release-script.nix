{
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    devenv.shells.release-script = {
      languages.python = {
        enable = true;
        package = pkgs.python313;
        uv = {
          enable = true;
          package = pkgs.uv;
        };
      };

    };
  };
}
