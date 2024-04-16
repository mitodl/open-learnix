{
  perSystem = {
    config,
    system,
    pkgs,
    pkgs-unstable,
    ...
  }: let
    devenvRoot = config.devenv.shells.default.env.DEVENV_ROOT;
  in {
    devenv.shells.default = {
      packages = [
        pkgs.git
        pkgs.pre-commit
        pkgs.nodejs
        pkgs.python3
        pkgs.poetry
        pkgs.gcc
        pkgs.detect-secrets
        # newer versions of ruff require a newer version of rustc/cargo to build
        # these are only available in unstable at this time
        pkgs-unstable.cargo
        pkgs-unstable.rustc
      ];

      env = {
        PRE_COMMIT_HOME = "${devenvRoot}/.cache/pre-commit";
        PIP_NO_BINARY = "ruff";
      };

      scripts = {
        ol-generate-network-overrides.exec = ''
          PROJECT=$1 ${pkgs.yq-go}/bin/yq --null-input '(
            load("templates/ol-network.base.yml") | .services |= (
              load("repos/" + strenv(PROJECT) + "/docker-compose.yml") 
              | ... comments=""
              | .services
              | map_values({"networks": ["default", "ol-network"]})
            )
          )'
        '';
        ol-dc.exec = ''
          COMPOSE_FILE=${devenvRoot}/docker-compose.yml docker compose $@
        '';
      };
    };
  };
}
