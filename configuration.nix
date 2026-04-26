{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;
  hardware.nvidia.modesetting.enable = true;

  networking.hostName = "Natetop"; 
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";

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
    wget
    git
    alacritty
    firefox
    hyprland
    hyprpaper
  ];

fonts.packages = with pkgs; [
nerd-fonts.iosevka
nerd-fonts.iosevka-term
];

#Programs
programs.zsh.enable = true;
programs.git = {
	enable = true;
	config.init.defaultBranch = "main";
};

#Users
environment.shells = with pkgs; [ zsh bash ];
users.defaultUserShell = pkgs.zsh;

  users.users.neidna = {
    isNormalUser = true;
    description = "Nathan Neidigh";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
