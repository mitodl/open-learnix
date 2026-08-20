{
  perSystem = {
    config,
    lib,
    pkgs,
    pkgs-unstable,
    ...
  }: {
    devenv.shells.ol-infrastructure = lib.mkMerge [
      (import ../lib/ol-common.nix {
        inherit lib pkgs pkgs-unstable;
        devenvRoot = config.devenv.shells.ol-infrastructure.env.DEVENV_ROOT;
        repoSubdir = "repos/ol-infrastructure";
      })
      {
        packages = with pkgs; [
          awscli2
          kubernetes-helm
          k3d
          kubectl
          mkcert
          pulumi-bin
          tilt
          uv
        ];
      }
    ];
  };
}
