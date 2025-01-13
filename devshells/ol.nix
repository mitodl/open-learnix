{
  perSystem = {
    config,
    system,
    pkgs,
    pkgs-unstable,
    ...
  }: let
    devenvRoot = config.devenv.shells.default.env.DEVENV_ROOT;
  in {
    devenv.shells = {
      default = {
        packages = [
          pkgs.git
          pkgs.pre-commit
          pkgs.nodejs
          pkgs.python312
          pkgs.poetry
          pkgs.gcc
          pkgs.detect-secrets
          pkgs.mkcert
          pkgs.openssl
          # newer versions of ruff require a newer version of rustc/cargo to build
          # these are only available in unstable at this time
          pkgs-unstable.cargo
          pkgs-unstable.rustc
        ];

        dotenv.disableHint = true;

        env = {
          PRE_COMMIT_HOME = "${devenvRoot}/.cache/pre-commit";
          PIP_NO_BINARY = "ruff";
          OL_ROOT = "${devenvRoot}";
        };

        pre-commit = {
          hooks = {
            # actionlint.enable = true;
            # treefmt = {
            #   enable = true;
            #   package = config.treefmt.build.wrapper;
            # };
            # markdownlint.enable = true;
            # yamllint.enable = true;
          };

          settings = {
            markdownlint.config = {
              # party like it's not 1999
              MD013 = {
                line_length = 120;
                heading_line_length = 120;
                code_block_line_length = 120;
              };
            };
          };
        };

        scripts = {
          ol-generate-network-overrides.exec = ''
            PROJECT=$1 ${pkgs.yq-go}/bin/yq --null-input '(
              load("templates/ol-network.base.yml") | .services |= (
                load("repos/" + strenv(PROJECT) + "/docker-compose.yml")
                | ... comments=""
                | .services
                | map_values({"networks": ["default", "ol-network"]})
              )
            )'
          '';
          ol-dc.exec = ''
            ${builtins.readFile ../bin/ol-stdlib.sh}

            ol_dc_cmd "${devenvRoot}" "$@"
          '';
        };

        enterShell = let
            certsPath = "${devenvRoot}/certs";
            certFile = "${certsPath}/odl.local.crt";
            keyFile = "${certsPath}/odl.local.key";
            pemFile = "${certsPath}/odl.local.pem";
        in ''
          mkcert \
            --cert-file ${certFile} \
            --key-file ${keyFile} \
            "odl.local" \
            "*.odl.local" \
            "*.learn.odl.local"

            openssl x509 -in ${certFile} -out ${pemFile} -outform PEM
        '';
      };
    };


    treefmt = {
      projectRootFile = "flake.nix";
      programs.nixfmt.enable = true;
      settings.global.excludes = ["./repos"];
    };
  };
}
