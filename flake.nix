{
  description = "Open Learning engineering nix toolset.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    systems.url = "github:nix-systems/default";
    
    flake-parts.url = "github:hercules-ci/flake-parts";
    devenv.url = "github:cachix/devenv/caf1a2ea564c31f2ee70bc67af56f77a2758848a";

    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    flake-parts,
    systems,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import systems;

      perSystem = { config, system, ...}: {
        _module.args = {
          pkgs = import inputs.nixpkgs {inherit system;};
          pkgs-unstable = import inputs.nixpkgs-unstable {inherit system;};
        };
      };

      imports = [
        inputs.devenv.flakeModule
      ] ++ (builtins.attrValues (inputs.haumea.lib.load {
        src = ./devshells;
        loader = inputs.haumea.lib.loaders.path;
      }));
    };
}
