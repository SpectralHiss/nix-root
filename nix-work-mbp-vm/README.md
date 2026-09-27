# nix-work-mbp-vm — `utm-work` (UTM VM on Apple Silicon, aarch64-linux)

Run from this directory.

## Update & rebuild

```sh
nix flake update                              # bump nixpkgs + home-manager pins
sudo nixos-rebuild switch --flake .#utm-work  # build & activate
```

`./rebuild.sh` rebuilds without updating `flake.lock`.
