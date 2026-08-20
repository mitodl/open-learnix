# Shared devenv configuration for every shell in this workspace.
#
# Per-repo shells merge this in so that a single `use flake` provides both the
# common workspace tooling and the repo-specific tooling. Loading a second shell
# via `source_env ../../` is what used to make nix-direnv re-evaluate on every
# directory change: on a cache hit nix-direnv touches the first shell's cached
# profile to refresh its gcroots, and the second shell then always sees that
# file as newer than its own cache.
{
  lib,
  pkgs,
  pkgs-unstable,
  # DEVENV_ROOT of the shell this is merged into. Under `--impure` devenv sets
  # it to the directory direnv loaded the flake from, i.e. the repo checkout.
  devenvRoot,
  # That checkout's path relative to the workspace root ("" for the workspace
  # root itself). Used to recover the workspace root from devenvRoot.
  repoSubdir ? "",
}: let
  olRoot =
    if repoSubdir == ""
    then devenvRoot
    else if lib.hasSuffix "/${repoSubdir}" devenvRoot
    then lib.removeSuffix "/${repoSubdir}" devenvRoot
    else
      throw ''
        ol-common: expected DEVENV_ROOT (${devenvRoot}) to end in "${repoSubdir}".
        The repo's .envrc must load the flake from the repo directory itself,
        e.g. `use flake ../../#<shell> --impure` from ${repoSubdir}.
      '';

  certsPath = "${olRoot}/certs";
  certFile = "${certsPath}/odl.local.crt";
  keyFile = "${certsPath}/odl.local.key";
  pemFile = "${certsPath}/odl.local.pem";
in {
  packages = [
    pkgs.git
    pkgs.pre-commit
    pkgs.nodejs
    pkgs.nvfetcher
    pkgs.python312
    pkgs.poetry
    pkgs.gcc
    pkgs.detect-secrets
    pkgs.mkcert
    pkgs.openssl
    pkgs.uv
    # newer versions of ruff require a newer version of rustc/cargo to build
    # these are only available in unstable at this time
    pkgs-unstable.cargo
    pkgs-unstable.rustc
  ];

  dotenv.disableHint = true;

  env = {
    PRE_COMMIT_HOME = "${olRoot}/.cache/pre-commit";
    PIP_NO_BINARY = "ruff";
    OL_ROOT = olRoot;
    SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt"; # fix python urllib cert resolution
  };

  git-hooks = {
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
    ol-dc.exec = ''
      ${builtins.readFile ../bin/ol-stdlib.sh}

      ol_dc_cmd "${olRoot}" "$@"
    '';
    tutor.exec = ''uv run tutor "$@"'';
  };

  enterShell = ''
    mkcert \
      --cert-file ${certFile} \
      --key-file ${keyFile} \
      "odl.local" \
      "*.odl.local" \
      "*.learn.odl.local" \
      "*.mitxonline.odl.local" \
      "*.openedx.odl.local" \
      "*.internal.odl.local"

      openssl x509 -in ${certFile} -out ${pemFile} -outform PEM
  '';
}
