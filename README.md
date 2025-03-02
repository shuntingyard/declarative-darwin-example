# Declarative Darwin Example

First steps towards configuring MacOS with as few manual (aka imperative) steps as possible.

## Prerequisites

### nix-darwin

I consider it good practice to use Determinate System's installer, and let the former manage the Nix environment.

Command to run:

```
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install
```

### Homebrew

Homebrew is managed by `nix-darwin`, but like the latter, it requires a manual installation step.

## Installation

Initially you need to clone this repository.

Then simply run:

```
nix run nix-darwin -- switch --flake .
```
