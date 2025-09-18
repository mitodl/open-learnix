{
  perSystem = {pkgs, ...}: let
    pyVersion = "313";
  in {
    devenv.shells.ol-infrastructure = {
      packages = [
        pkgs.awscli2
        pkgs.kubectl
      ];
      languages.python = {
        enable = true;
        package = pkgs."python${pyVersion}";
        uv = {
          enable = true;
        };
      };
    };
  };
}
