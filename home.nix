{ config, pkgs, ... }:

let
	myAliases = {};
in {
	home.username = "neidna";
	home.homeDirectory = "/home/neidna";
	home.stateVersion = "25.11";
	
	#Packages
	home.packages = with pkgs; [
		starship
	];

	#Programs
	programs.git = {
		enable = true;
		settings = {
			user.email = "nathan.neidigh@outlook.com";
			user.name = "Nathan Neidigh";
			core.editor = "vim";
		};
	};
	programs.ssh = {
		enable = true;
		matchBlocks = {
			"github.com" = {
				hostname = "github.com";
				identityFile = "~/.ssh/id_ed25519";
				user = "git";
			};
		};
	};
	programs.bash = {
		enable = true;
		shellAliases = myAliases;
	};
	programs.zsh = {
		enable = true;
		shellAliases = myAliases;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;
	};
	programs.starship = {
		enable = true;
	};
	home.file.".config/hypr/hyprland.conf".source = ./config/hypr/hyprland.conf;
	home.file.".config/hypr/hyprpaper.conf".source = ./config/hypr/hyprpaper.conf;
	home.file.".config/alacritty/alacritty.toml".source = ./config/alacritty/alacritty.toml;
	
	#Cursor
	home.pointerCursor = {
		gtk.enable = true;
		#x11.enable = true;
		package = pkgs.bibata-cursors;
		name = "Bibata-Modern-Ice";
		size = 24;
	};
	
	gtk = {
		enable = true;
		theme = {
			package = pkgs.adw-gtk3;
			name = "adw-gtk3";
		};
		cursorTheme = {
			package = pkgs.bibata-cursors;
			name = "Bibata-Modern-Ice";
		};
	};
}
