{
  description = "Open Learing engineering nix toolset.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devshell.url = "github:numtide/devshell";

    # this is used solely for this flake repo
    pre-commit-hooks-nix.url = "github:cachix/pre-commit-hooks.nix";
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
        inputs.devshell.flakeModule
        inputs.pre-commit-hooks-nix.flakeModule
      ];

      perSystem = {
        config,
        system,
        ...
      }: let
        pkgs = import inputs.nixpkgs {inherit system;};
        unstable = import inputs.nixpkgs-unstable {inherit system;};
      in {
        devshells.default = {
          devshell = {
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

            startup.pre-commit.text = ''
              ${config.pre-commit.installationScript}
            '';
          };

          env = [
            {
              name = "PRE_COMMIT_HOME";
              eval = "$PRJ_ROOT/.cache/pre-commit";
            }
            {
              name = "PIP_NO_BINARY";
              value = "ruff";
            }
          ];
        };

        formatter = pkgs.alejandra;

        pre-commit = {
          inherit pkgs;
          settings = {
            hooks = {
              actionlint.enable = true;
              alejandra.enable = true;
              markdownlint.enable = true;
              yamllint.enable = true;
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
        };
      };
    };
}
