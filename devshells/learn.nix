{
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devenv.shells.learn = {
      dotenv.disableHint = true;

      env = {
        COMPOSE_FILE = "docker-compose.yml:../../docker-compose.learn.yml";
        # COMPOSE_PROFILES = "backend,frontend,notebook,load-testing";
        COMPOSE_PROFILES = "backend,frontend,load-testing";
        # OPENSEARCH_CLUSTER_TYPE = "cluster";
      };

      enterShell = ''
        cp $(${pkgs.mkcert}/bin/mkcert -CAROOT)/rootCA.pem certs/mkcert-rootCA.crt
      '';
    };
  };
}
