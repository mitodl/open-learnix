{
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devenv.shells.learn = {
      env = {
        COMPOSE_FILE = "docker-compose.yml:../../docker-compose.learn.yml";
        # COMPOSE_PROFILES = "backend,frontend,notebook,load-testing";
        COMPOSE_PROFILES = "backend,frontend";
        # OPENSEARCH_CLUSTER_TYPE = "cluster";
      };
    };
  };
}
