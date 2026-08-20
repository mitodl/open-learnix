{
  perSystem = {pkgs, ...}:{
    devenv.shells.ol-infrastructure = {
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
    };
  };
}
