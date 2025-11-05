{
  description = "Open Learning engineering nix toolset.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    systems.url = "github:nix-systems/default";

    flake-parts.url = "github:hercules-ci/flake-parts";
    devenv.url = "github:cachix/devenv";
    treefmt-nix.url = "github:numtide/treefmt-nix";

    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    flake-parts,
    systems,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import systems;

      perSystem = {
        system,
        pkgs,
        ...
      }: {
        _module.args = {
          pkgs = import inputs.nixpkgs {inherit system;};
          pkgs-unstable = import inputs.nixpkgs-unstable {inherit system;};
          pkgs-local = import ./pkgs { inherit pkgs; };
        };
      };

      imports =
        [
          inputs.devenv.flakeModule
          inputs.treefmt-nix.flakeModule
        ]
        ++ (builtins.attrValues (
          inputs.haumea.lib.load {
            src = ./devshells;
            loader = inputs.haumea.lib.loaders.path;
          }
        ));
    };
}
