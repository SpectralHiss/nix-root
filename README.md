# nix-root

Modular NixOS configs. Each machine target is a flake; `homes/home.nix` is
the shared home-manager configuration imported by the machine flakes.

| Path | Target | Platform |
| --- | --- | --- |
| [`nix-vm/`](nix-vm/README.md) | `nixos` — dev-machine QEMU/KVM VM | x86_64-linux |
| [`nix-work-mbp-vm/`](nix-work-mbp-vm/README.md) | `utm-work` — UTM VM on MacBook Pro | aarch64-linux |
| [`nix-minimal-iso/`](nix-minimal-iso/README.md) | `exampleIso` — installer ISO | aarch64-linux |

General workflow per target: `nix flake update` to pull the latest
nixpkgs/home-manager into `flake.lock`, then rebuild (see each README).

Flakes only see git-tracked files: `git add` any new file before rebuilding.
