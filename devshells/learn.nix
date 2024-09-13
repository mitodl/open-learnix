{
  perSystem = {
    config,
    pkgs,
    ...
  }: let
    devenvRoot = config.devenv.shells.default.env.DEVENV_ROOT;
  in {
    devenv.shells.learn = {
      env = {
        COMPOSE_FILES = "docker-compose.yml:${devenvRoot}/docker-compose.ol-network.yml";
        COMPOSE_PROFILES = "backend,frontend,notebook,load-testing";
        OPENSEARCH_CLUSTER_TYPE = "cluster";
      };
    };
  };
}
