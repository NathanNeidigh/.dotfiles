{ config, pkgs, specialArgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;
  hardware.nvidia.modesetting.enable = true;

  networking.hostName = "${specialArgs.hostname}"; 
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";
  
  system.autoUpgrade = {
	enable = true;
	dates = "weekly";
	flake = "/home/${specialArgs.username}/.dotfiles";
  };

  nix.gc = {
	automatic = true;
	dates = "daily";
	options = "--delete-older-than 10d";
  };

  #nix.settings.auto-optimize-store = true;

#Services
  services.displayManager.ly = {
	enable = true;
	settings = {
		clock = "%c";
		save = true;
		load = true;
		auth_fails = 3;
		clear_password = true;
		bigclock = "en";
		inactivity_cmd = "/run/current-system/sw/bin/systemctl suspend";
		inactivity_delay = 300;
		sleep_cmd = "/run/current-system/sw/bin/systemctl suspend";
	};
};

  programs.hyprland.enable = true;

#Packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim 
    neovim
    wget
    git
    alacritty
    firefox
    hyprland
    hyprpaper
    kicad
  ];

fonts.packages = with pkgs; [
nerd-fonts.iosevka
nerd-fonts.iosevka-term
];

#Programs
programs = {
	zsh.enable = true;
	git = {
		enable = true;
		config.init.defaultBranch = "main";
	};
	neovim = {
		enable = true;
		defaultEditor = true;
		viAlias = true;
		vimAlias = true;
		withPython3 = false;
		withRuby = false;
	};
};

#Users
environment.shells = with pkgs; [ zsh bash ];
users.defaultUserShell = pkgs.zsh;

  users.users."${specialArgs.username}" = {
    isNormalUser = true;
    description = "Nathan Neidigh";
    initialHashedPassword = "${specialArgs.passwordHash}";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = specialArgs.stateVersion; # Did you read the comment?
}
