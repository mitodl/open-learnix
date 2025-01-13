{
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devenv.shells.discussions = {
      dotenv.disableHint = true;

      env = {
        COMPOSE_FILE = "docker-compose.yml:../../docker-compose.discussions.yml";
      };

      enterShell = ''
        cp $(${pkgs.mkcert}/bin/mkcert -CAROOT)/rootCA.pem certs/mkcert-rootCA.crt
      '';
    };
  };
}
