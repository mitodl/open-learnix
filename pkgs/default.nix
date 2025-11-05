{ pkgs }:
let 
  sources = pkgs.callPackage ./_sources/generated.nix {};
in {
  uv = pkgs.uv.overrideAttrs (_: _: {
    inherit (sources.uv) version src;

    cargoHash = "";
  });
}
