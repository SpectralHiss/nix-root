{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.grub = {
	enable = true;

  	device = "nodev"; # Seems to be critical for UTM UEFI boot emulation mode
        efiSupport = true;
	efiInstallAsRemovable = true;
  };

  boot.loader.efi.canTouchEfiVariables = false;

  networking.hostName = "utm-work";
  networking.wireless.enable = false;


  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  services.xserver.displayManager.sessionCommands = ''
  xrandr --output default --mode 1920x1080
  '';
  services.xserver.enable = true;

  services.xserver.desktopManager.xfce.enable = true;
  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings = {
    data-root = "/data/var/docker";
  };

  users.users.houssem = {
    shell = pkgs.zsh;
    initialPassword = "basswerd";
    isNormalUser = true;
    description = "Houssem";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      firefox
    ];
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
    extraConfig = ''
      %wheel ALL=(ALL:ALL) ALL
    '';
  };
  programs.zsh.enable = true;

  services.openssh.enable = true;

  system.stateVersion = "24.11";

  nix.gc = {
	automatic = true;
	dates = "weekly";
	options = "--delete-older-than 7d";
  };

}
