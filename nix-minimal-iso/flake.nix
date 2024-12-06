{
  description = "A flake to generate a flake compatible ISO";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
  };


outputs = { nixpkgs, ... }@inputs:
    {
      nixosConfigurations = {

        exampleIso = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./configuration.nix
          ];
        };

      };
    };	

}
