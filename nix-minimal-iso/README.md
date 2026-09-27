# nix-minimal-iso — minimal NixOS installer ISO (aarch64-linux)

Run from this directory.

## Update & build

```sh
nix flake update                                                        # bump nixpkgs pin
nix build .#nixosConfigurations.exampleIso.config.system.build.isoImage
```

The ISO image lands in `result/iso/`.
