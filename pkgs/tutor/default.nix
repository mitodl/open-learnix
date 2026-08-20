# tutor[full]: the Open edX tutor CLI plus every plugin in upstream's `full` extra.
#
# nixpkgs carries none of these, so each one is built from the PyPI sdist pinned by
# nvfetcher in ../nvfetcher.toml. They are all hatchling projects and differ only in
# module name and dependencies, so a single helper covers the lot.
{
  lib,
  python3,
  runCommandLocal,
  makeWrapper,
  sources,
}:
let
  # tutor pins click<8.3.0, and click-repl (pulled in by tutor-deck) is broken on
  # click>=8.2.0, which is why nixpkgs marks it broken against its own click 8.3.x.
  # Building the whole set against the pinned click 8.1.8 satisfies both constraints
  # and un-breaks nixpkgs' click-repl, rather than relaxing the bound and shipping a
  # tutor-deck whose REPL cannot start.
  python = python3.override {
    self = python;
    packageOverrides = _final: prev: {
      click = prev.click.overridePythonAttrs (old: {
        inherit (sources.click) version src;
        meta = old.meta // {
          changelog = "https://github.com/pallets/click/blob/${sources.click.version}/CHANGES.rst";
        };
      });
    };
  };

  py = python.pkgs;

  mkTutorPkg =
    {
      source,
      module,
      deps ? [ ],
    }:
    py.buildPythonPackage {
      inherit (source) pname version src;
      pyproject = true;
      build-system = [ py.hatchling ];
      dependencies = deps;
      # The sdists ship no test suite, so the import check is the real gate.
      pythonImportsCheck = [ module ];
    };

  tutor-lib = mkTutorPkg {
    source = sources.tutor;
    module = "tutor";
    deps = with py; [
      appdirs
      click
      importlib-metadata
      importlib-resources
      jinja2
      kubernetes
      mypy
      packaging
      pycryptodome
      pyyaml
      typing-extensions
    ];
  };

  plugin =
    name: module: extra:
    mkTutorPkg {
      source = sources.${name};
      inherit module;
      deps = [ tutor-lib ] ++ extra;
    };

  # Named separately because other plugins depend on them.
  mfe = plugin "tutor-mfe" "tutormfe" [ ];
  discovery = plugin "tutor-discovery" "tutordiscovery" [ ];
  minio = plugin "tutor-minio" "tutorminio" [ ];

  plugins = [
    (plugin "tutor-android" "tutorandroid" [ ])
    (plugin "tutor-cairn" "tutorcairn" [ ])
    (plugin "tutor-credentials" "tutorcredentials" [
      discovery
      mfe
    ])
    (plugin "tutor-deck" "tutordeck" (
      with py;
      [
        aiofiles
        click
        click-repl
        markdown
        quart
      ]
    ))
    (plugin "tutor-forum" "tutorforum" [ ])
    (plugin "tutor-indigo" "tutorindigo" [ mfe ])
    (plugin "tutor-jupyter" "tutorjupyter" [ mfe ])
    (plugin "tutor-livedeps" "tutorlivedeps" [ minio ])
    (plugin "tutor-notes" "tutornotes" [ ])
    (plugin "tutor-xqueue" "tutorxqueue" [ ])
    discovery
    mfe
    minio
  ];

  # tutor finds plugins through entry points, so the library and every plugin have to
  # share one interpreter environment.
  env = python.withPackages (_: [ tutor-lib ] ++ plugins);
in
# Expose only bin/tutor. `env` also carries python3/pydoc3/mypy, and a second python3
# in a devenv profile would collide with the pkgs.python312 in lib/ol-common.nix.
# docker and docker compose are deliberately left off the wrapper's PATH so tutor keeps
# using the host CLI and daemon.
runCommandLocal "tutor-${tutor-lib.version}"
  {
    nativeBuildInputs = [ makeWrapper ];
    passthru = { inherit env plugins tutor-lib; };
    meta = {
      description = "Docker-based Open edX distribution, with the full plugin set";
      homepage = "https://docs.tutor.edly.io/";
      license = lib.licenses.agpl3Only;
      mainProgram = "tutor";
    };
  }
  ''
    mkdir -p $out/bin
    makeWrapper ${env}/bin/tutor $out/bin/tutor
  ''
