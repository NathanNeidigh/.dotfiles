{ config, pkgs, stateVersion, username, gitUsername, gitUseremail, ... }:

{
	home.username = username;
	home.homeDirectory = "/home/${username}";
	home.stateVersion = stateVersion;
	
	#Packages
	home.packages = with pkgs; [
		starship
	];

	#Programs
	programs = {
		git = {
			enable = true;
			settings = {
				user.email = gitUseremail;
				user.name = gitUsername;
				core.editor = "nvim";
			};
		};
		ssh = {
			enable = true;
			matchBlocks = {
				"github.com" = {
					hostname = "github.com";
					identityFile = "~/.ssh/id_ed25519";
					user = "git";
				};
			};
		};
		bash = {
			enable = true;
		};
		zsh = {
			enable = true;
			autosuggestion.enable = true;
			syntaxHighlighting.enable = true;
		};
		starship = {
			enable = true;
		};
		neovim = {
			enable = true;
			sideloadInitLua = true;
			withPython3 = false;
			withRuby = false;
		};
	};

	#Configuration Files
	xdg.configFile."alacritty".source = config/alacritty/alacritty.toml;
	xdg.configFile."hypr" = {
		source = config/hypr;		
		recursive = true;
	};
	xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/config/nvim";
	
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
