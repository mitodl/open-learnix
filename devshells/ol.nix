{
  perSystem = {
    config,
    lib,
    pkgs,
    pkgs-unstable,
    ...
  }: {
    devenv.shells.default = import ../lib/ol-common.nix {
      inherit lib pkgs pkgs-unstable;
      devenvRoot = config.devenv.shells.default.env.DEVENV_ROOT;
    };

    treefmt = {
      projectRootFile = "flake.nix";
      programs.nixfmt.enable = true;
      settings.global.excludes = ["./repos"];
    };
  };
}
