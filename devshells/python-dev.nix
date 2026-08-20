{
  perSystem = {
    pkgs,
    ...
  }: {
    devenv.shells.python-dev = {
      packages = with pkgs; [
        python310
        python311
        python312
        python313
        python314
      ] ++ (with pkgs.python313Packages; [
          tox
          isort

      ]);
    };
  };
}
