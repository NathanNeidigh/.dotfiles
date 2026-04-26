{ config, pkgs, ... }:

let
	myAliases = {};
in {
	home.username = "neidna";
	home.homeDirectory = "/home/neidna";
	home.stateVersion = "25.11";
	
	#Programs
	programs.git = {
		enable = true;
		settings = {
			user.email = "nathan.neidigh@outlook.com";
			user.name = "Nathan Neidigh";
			core.editor = "vim";
		};
	};
	programs.bash = {
		enable = true;
		shellAliases = myAliases;
	};
	programs.zsh = {
		enable = true;
		shellAliases = myAliases;
	};
	home.file.".config/hypr/hyprland.conf".source = ./config/hypr/hyprland.conf;
	home.file.".config/hypr/hyprpaper.conf".source = ./config/hypr/hyprpaper.conf;
	
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
