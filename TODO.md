# Pending changes

State as of 2026-09-27: `nix-vm` is now flake-based (pinned `nixos-26.05` +
home-manager `release-26.05`, matching the running system), validated by
evaluation only — **nothing has been activated yet**.

## 1. Do first (next session)

- [ ] Commit the current work (new files are only `git add -N` intent-to-add):
  ```sh
  git add -A && git commit
  ```
- [ ] First flake rebuild on `nix-vm` (this machine):
  ```sh
  cd ~/Desktop/00SpectralHiss/nix-root/nix-vm
  sudo NIX_CONFIG="experimental-features = nix-command flakes" \
    nixos-rebuild switch --flake .#nixos
  ```
  After this, plain `nix` / `nixos-rebuild` work (experimental-features are
  now set in `configuration.nix`).
- [ ] Update the zsh `update` alias in `homes/home.nix` — it still runs legacy
  `sudo nixos-rebuild switch` (rebuilds `/etc/nixos` via channels, bypassing
  the flake). Change to:
  ```nix
  update = "sudo nixos-rebuild switch --flake ~/Desktop/00SpectralHiss/nix-root/nix-vm#nixos";
  ```

## 2. Deprecation fixes — `nix-vm/configuration.nix` (was "step 3")

- [ ] `services.xserver.layout` → `services.xserver.xkb.layout`
- [ ] `services.xserver.xkbVariant` → `services.xserver.xkb.variant`
- [ ] `hardware.pulseaudio.enable` → `services.pulseaudio.enable`

## 3. Deprecation fixes — `homes/home.nix`

(from evaluation warnings on home-manager release-26.05)

- [ ] `programs.zsh.initExtra` → `programs.zsh.initContent`
- [ ] `programs.git.userName` / `userEmail` → `programs.git.settings.user.name` / `user.email`
- [ ] `programs.git.aliases` → `programs.git.settings.alias`
- [ ] `programs.vscode.extensions` → `programs.vscode.profiles.default.extensions`
- [ ] Use the `programs.vscodium` module instead of `programs.vscode` with
  `package = pkgs.vscodium` (writes config to the fork's own paths)
- [ ] kimi-cli: `${pkgs.system}` → `${pkgs.stdenv.hostPlatform.system}`
- [ ] Remove `nixpkgs.config.allowUnfree` from `home.nix` (incompatible with
  `useGlobalPkgs` in future home-manager; the system-level one in
  `configuration.nix` already covers it)

## 4. Upgrade remaining flakes (24.05 → 26.05)

- [ ] `nix-work-mbp-vm/flake.nix`: bump `nixos-24.05` → `nixos-26.05` and
  `release-24.05` → `release-26.05`, then `nix flake update`
  - Required config fix when upgrading: remove `sound.enable = true;`
    (option removed upstream), plus the same xkb/pulseaudio renames as §2
  - Leave `system.stateVersion = "24.11"` unchanged (it tracks the install
    version, not the channel)
- [ ] `nix-minimal-iso/flake.nix`: same nixpkgs bump, `nix flake update`,
  then rebuild the ISO per its README

## 5. Optional cleanup (after the flake rebuild is confirmed working)

- [ ] Remove obsolete `/etc/nixos/configuration.nix*` on `nix-vm` (including
  the `configuration.nix-<timestamp>` backups left by the old `update.sh`)
- [ ] Remove now-unused channels: `sudo nix-channel --list` /
  `nix-channel --remove nixos` etc. (flake.lock replaces them)
- [ ] `sudo nix-collect-garbage -d` once everything is stable
- [ ] Consider adding `nix.gc` settings to `nix-vm` (currently only
  `nix-work-mbp-vm` has automatic weekly GC)
