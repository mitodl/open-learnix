{
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    devenv.shells.release-script = {
      env = {
        UV_PROJECT_ENVIRONMENT = lib.mkForce "./repos/release-script/.venv/";
      };

      languages.python = {
        enable = true;
        package = pkgs.python314;
        uv = {
          enable = true;
          package = pkgs.uv;
        };
      };

    };
  };
}
