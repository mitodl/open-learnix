# open-learnix

A toolset for working with [Open Learning Engineering](https://github.com/mitodl) projects in a Nixos environment.

## Prerequisites

- [Install nix/nixos](https://nixos.org/download.html)
- [Install `direnv`](https://direnv.net/docs/installation.html)
- [Install `nix-direnv`](https://github.com/nix-community/nix-direnv)

## Setup

To setup this project, you can simply run these commands:

```bash
echo "use flake" > .envrc
direnv allow .
```

After running those commands, direnv will setup the flake. This will take some time and is resource intensive so it
will probably run faster if you shutdown other nonessential programs, particularly if they're CPU heavy. This is
largely a one-time operation unless the dependencies in this project change.

## Usage

### Cloning projects

Open Learning projects should be cloned into a `repos/` directory in this project. This directory is gitignored to
guarantee that nested projects don't get committed. For example:

```bash
mkdir -p repos
cd repos
git clone git@github.com:mitodl/mitxpro.git
```

### pre-commit

`pre-commit` should generally work out of the box with the standard `pre-commit install`.

If a project is using `pre-commit` hooks that haven't been accounted for here, you may need to update this project
to support it. This project currently addresses the necessary environment setup to install the following hooks:

- Python-based:
  - `ruff`
  - `black`
- Nodejs-based:
  - `prettier`
  - `prettier-django`
  - `eslint`
  - `scss-lint`
