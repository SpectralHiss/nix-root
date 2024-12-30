# /etc/nixos/flake.nix
{
  inputs = {
    home-manager = {
	url =  "github:nix-community/home-manager/release-24.05";
	inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };
  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.utm-work = let 
	pkgs = import nixpkgs {
		system = "aarch64-linux";
		config = {
			allowUnfree = true;
			allowUnfreePredicate = _: true;
		};
	};
	in nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = inputs // { pkgs = pkgs; };
      modules = [ 
	./configuration.nix
	home-manager.nixosModules.home-manager
	{
		home-manager.users.houssem = {
		  imports = [ ../homes/home.nix ];
		};
                home-manager.useGlobalPkgs = true;
		home-manager.useUserPackages = true;
	}
      ];
    };
  };
}
