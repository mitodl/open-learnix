{
  perSystem = _: {
    devenv.shells.mitxonline = {
      dotenv.disableHint = true;

      env = {
        COMPOSE_FILE = "docker-compose.yml:../../docker-compose.mitxonline.yml";
      };

      # enterShell = ''
      #   cp $(${pkgs.mkcert}/bin/mkcert -CAROOT)/rootCA.pem certs/mkcert-rootCA.crt
      # '';
    };
  };
}
