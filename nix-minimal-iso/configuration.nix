
{ pkgs, modulesPath, ... }: {

  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
  ];

  nixpkgs.hostPlatform = "aarch64-linux";

  environment.systemPackages = with pkgs; [
	neovim
	disko
	parted
	git
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.hyprland.enable = true;

}
