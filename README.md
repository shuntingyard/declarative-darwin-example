# Declarative Darwin Example

First steps towards configuring MacOS with as few manual (aka imperative) steps
as possible.

## Prerequisites

### Nix

So far I consider it good practice to use Determinate System's installer,
and let it manage the Nix environment.

Command to run:

```
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install
```

### Homebrew

Homebrew is managed by `nix-darwin`, but still requires manual installation
as a first step.

## Being Declarative

Here this means using a flake to leverage the power of `nix-darwin` and
`home-manager`.

## Installation

Clone this repository and run:

```
nix run nix-darwin -- switch --flake .
```
