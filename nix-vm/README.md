# nix-vm — `nixos` (dev-machine QEMU/KVM, x86_64-linux)

Run from this directory.

## Update & rebuild

```sh
nix flake update                            # bump nixpkgs + home-manager pins
sudo nixos-rebuild switch --flake .#nixos   # build & activate
```

## First run (flakes not yet enabled on the machine)

```sh
sudo NIX_CONFIG="experimental-features = nix-command flakes" \
  nixos-rebuild switch --flake .#nixos
```

After the first rebuild, `nix.settings.experimental-features` in
`configuration.nix` makes the plain commands above work.
