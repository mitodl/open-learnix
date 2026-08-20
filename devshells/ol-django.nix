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
      packages = with pkgs;[
        python311
        python312
        python313
        python314
        uv
      ];

      scripts = {
        pg-start.exec = "docker compose up -d";
        pg-stop.exec = "docker compose stop";
        psql.exec = "docker compose exec db psql $@";
      };
    };
  };
}
