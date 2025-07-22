
{
  perSystem = {
    config,
    pkgs,
    ...
  }: 
   {
    devenv.shells.ol-keycloak = {
      languages.java = {
        enable = true;
        gradle.enable = true;
      };
    };
  };
}
