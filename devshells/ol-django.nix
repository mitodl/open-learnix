{
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    devenv.shells.ol-django = {
      env = {
        LD_LIBRARY_PATH = "{pkgs.xmlsec}/lib:$LD_LIBRARY_PATH";
        UV_PROJECT_ENVIRONMENT = lib.mkForce "./repos/ol-django/.venv/";
      };

      languages.python = {
        enable = true;
        uv = {
          enable = true;
          package = pkgs.uv;
        };
      };

      scripts = {
        pg-start.exec = "docker compose up -d";
        pg-stop.exec = "docker compose stop";
        psql.exec = "docker compose exec db psql $@";
      };
    };
  };
}
