{
  perSystem = { config, ... }: {
    devenv.shells.ol-infrastructure = {
      languages.python = {
        enable = true;
        poetry.enable = true;
      };

      enterShell = ''
        poetry install
        poetry shell
      '';
    };
  };
}
