
{
  perSystem = {
    config,
    pkgs,
    ...
  }: 
   {
    devenv.shells.ol-keycloakify = {
      languages.java = {
        enable = true;
        maven.enable = true;
      };
      languages.javascript = {
        enable = true;
        package = pkgs.nodejs_24;
        yarn.enable = true;
      };
    };
  };
}
