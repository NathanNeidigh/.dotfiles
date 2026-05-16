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
	let
		hostname = "Natetop";
		system = "x86_64-linux";
		stateVersion = "25.11";
		
		username = "neidna";
		passwordHash = "$6$KLg2NC/69aN1ylWV$eRCnyJFZiD9QayML60pXbsYNyyBLrI4Lzt70ZkBVA/vHZOewCxvDpv5oYhWZhm3Drpyf3bqGCeL/xedzWD6.00"; 

		gitUsername = "NathanNeidigh";
		gitUseremail = "nathan.neidigh@outlook.com";
	in
		{
			nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem {
				system = system;
				
				specialArgs = {
					hostname = hostname;
					system = system;
					stateVersion = stateVersion;

					username = username;
					passwordHash = passwordHash;
					gitUsername = gitUsername;
					gitUseremail = gitUseremail;
				};
			
				modules = [ 
					{
						system.stateVersion = stateVersion; # DO NOT CHANGE THIS UNLESS YOU KNOW WHAT YOU ARE DOING.
					}
					./hardware-configuration.nix
					./configuration.nix
					home-manager.nixosModules.home-manager
					{
						home-manager = {
							useGlobalPkgs = true;
							useUserPackages = true;
							users."${username}" = ./home.nix;
							backupFileExtension = "backup";
							extraSpecialArgs = { inherit stateVersion username gitUsername gitUseremail; };
						};
					}
				 ];
			};
		};
}
