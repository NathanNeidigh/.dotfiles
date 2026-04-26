{
	description = "First Flake";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager/master";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, ... }:
		{
			nixosConfigurations.Natetop = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [ 
					./configuration.nix
					home-manager.nixosModules.home-manager
					{
						home-manager = {
							useGlobalPkgs = true;
							useUserPackages = true;
							users.neidna = import ./home.nix;
							backupFileExtension = "backup";
						};
					}
				 ];
			};
		};
}
