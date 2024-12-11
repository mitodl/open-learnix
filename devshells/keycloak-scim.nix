
{
  perSystem = {
    config,
    pkgs,
    ...
  }: 
   {
    devenv.shells.keycloak-scim = {
      languages.java = {
        enable = true;
        gradle.enable = true;
      };
    };
  };
}
