{
  description = "Open Learning engineering nix toolset.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devenv.url = "github:cachix/devenv/caf1a2ea564c31f2ee70bc67af56f77a2758848a";
  };

  outputs = inputs @ {
    self,
    flake-parts,
    systems,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import systems;

      imports = [
        inputs.devenv.flakeModule
      ];

      perSystem = {
        config,
        system,
        ...
      }: let
        pkgs = import inputs.nixpkgs {inherit system;};
        unstable = import inputs.nixpkgs-unstable {inherit system;};
      in {
        devenv.shells.default = {
          packages = [
            pkgs.git
            pkgs.pre-commit
            pkgs.nodejs
            pkgs.python3
            pkgs.poetry
            pkgs.gcc
            # newer versions of ruff require a newer version of rustc/cargo to build
            # these are only available in unstable at this time
            unstable.cargo
            unstable.rustc
          ];

          env = {
            PRE_COMMIT_HOME = "$DEVENV_ROOT/.cache/pre-commit";
            PIP_NO_BINARY = "ruff";
          };

          pre-commit = {
            hooks = {
              # actionlint.enable = true;
              alejandra.enable = true;
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
            ol-dc.exec = ''
              COMPOSE_FILE=$DEVENV_ROOT/docker-compose.yml docker compose $@
            '';
          };
        };

        formatter = pkgs.alejandra;
      };
    };
}
