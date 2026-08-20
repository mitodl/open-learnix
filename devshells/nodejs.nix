{
  perSystem = {pkgs, ...}: {
    devenv.shells.nodejs = {
      dotenv.disableHint = true;

      languages.javascript = {
        enable = true;
        yarn.enable = true;
        yarn.package = pkgs.yarn-berry;
        corepack.enable = true;
      };
    };
  };
}
