# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <nixos-hardware/lenovo/thinkpad/x220>
    ];

  # Use latest linux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.loader.timeout = 0;

  # Enable NTFS
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Host for open reddit
  networking.extraHosts = ''
    151.101.129.140   i.redditmedia.com
    52.34.230.181     www.reddithelp.com
    151.101.65.140    g.redditmedia.com
    151.101.65.140    a.thumbs.redditmedia.com
    151.101.1.140     new.reddit.com
    151.101.129.140   reddit.com
    151.101.129.140   gateway.reddit.com
    151.101.129.140   oauth.reddit.com
    151.101.129.140   sendbird.reddit.com
    151.101.129.140   v.redd.it
    151.101.1.140     b.thumbs.redditmedia.com
    151.101.1.140     events.reddit.com
    54.210.123.98     stats.redditmedia.com
    151.101.65.140    www.redditstatic.com
    151.101.193.140   www.reddit.com
    52.3.23.26        pixel.redditmedia.com
    151.101.65.140    www.redditmedia.com
    151.101.193.140   about.reddit.com
    52.203.76.9       out.reddit.com
  '';

  # Set your time zone.
  time.timeZone = "Asia/Makassar";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "id_ID.utf8";
    LC_IDENTIFICATION = "id_ID.utf8";
    LC_MEASUREMENT = "id_ID.utf8";
    LC_MONETARY = "id_ID.utf8";
    LC_NAME = "id_ID.utf8";
    LC_NUMERIC = "id_ID.utf8";
    LC_PAPER = "id_ID.utf8";
    LC_TELEPHONE = "id_ID.utf8";
    LC_TIME = "id_ID.utf8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;

  # BSPWM
  services.xserver.windowManager.bspwm.enable = true;

  # DWM
  services.xserver.windowManager.dwm.enable = true;
  services.dwm-status.enable = true;
# services.dwm-status.order = [ "audio" "backlight" "battery" "cpu_load" "network" "time" ];
  services.dwm-status.order = [ "audio" "backlight" "battery" "time" ];
  services.dwm-status.extraConfig = ''
  	debug = false
	separator = "    "
	
	[audio]
	control = "Master"
	mute = "ﱝ"
	template = "{ICO} {VOL}%"
	icons = ["奄", "奔", "墳"]
	
	[backlight]
	device = "intel_backlight"
	template = "{ICO} {BL}%"
	icons = ["", "", ""]

	[battery]
	charging = ""
	discharging = ""
	enable_notifier = true
	no_battery = ""
	notifier_critical = 10
	notifier_levels = [2, 5, 10, 15, 20]
	separator = " · "
	icons = ["", "", "", "", "", "", "", "", "", "", ""]
	
	[cpu_load]
	template = "{CL1} {CL5} {CL15}"
	update_interval = 20
	
	[network]
	no_value = "NA"
	template = "{IPv4} · {IPv6} · {ESSID}"
	
	[time]
	format = "%d-%m-%Y %H:%M"
	update_seconds = false
  '';

  nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: { src = /home/nix/dwm-6.3; });
    })
    (self: super: {
      dwm = super.dwm.overrideAttrs (oldAttrs: rec {
        patches = [
         ./dwm/dwm-systray-6.3.diff
         ./dwm/dwm-cool-autostart-6.2.diff
         ./dwm/dwm-ru_gaps-6.3.diff
         ./dwm/dwm-ru_bottomstack-6.2.diff
         ./dwm/dwm-warp-6.2.diff
         ./dwm/dwm-alwayscenter.diff
         ./dwm/dwm-pertag.diff
         ./dwm/dwm-hide_vacant_tags-6.3.diff
        ];
        configFile = super.writeText "config.h" (builtins.readFile ./dwm/config.h);
        postPatch = oldAttrs.postPatch or "" + "\necho 'Using own config file...'\n cp ${configFile} config.def.h";
      });
    })
  ];

  # Enable the Pantheon Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.defaultSession = "none+dwm";
  services.xserver.desktopManager.pantheon.enable = true;

  
  # zsh
    programs.zsh.enable = true;
    programs.zsh.autosuggestions.enable = true;
    programs.bash.enableCompletion = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };


  # Enable pactl for volume thinkpad x220
  #hardware.pulseaudio.package.pkgs = [ "pulseaudioFull" ];

  # Enable Backlight Thinkpad
   programs.light.enable = true;


  # Enable CUPS to print documents.
  #services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.polkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nix = {
    isNormalUser = true;
    description = "nix";
    extraGroups = [ 
	"wheel" 
    	"networkmanager" 
	"video" 
	"input"
	"storage"
	"libvirtd"
	];
  };


  users.extraUsers.nix = {
 	shell = pkgs.zsh;
   };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = false;
  services.xserver.displayManager.autoLogin.user = "nix";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


# Virtualization with qemu kvm
   virtualisation.libvirtd.enable = true;
   programs.dconf.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    virt-manager
    wget
    firefox
    neovim
    pfetch
    git
    feh
    picom
    sxhkd
    kitty
    zsh
    polybar
    rofi
    gnumake
    gnupatch
    st
    dmenu
    w3m
    scrot
    killall
    xclip
    obs-studio
    ffmpeg
    mpv
    gimp
    nodejs
    nodePackages.npm
    ntfs3g
    pasystray
    qogir-icon-theme
    qogir-theme
    lxappearance
    kdenlive
    youtube-dl
    vscodium
    unzip
    keepassxc
    luajit
    copyq
    ueberzug
    hugo
    pulseaudio
    pulseaudio-ctl
    rclone
    rclone-browser
    scrot
    sxiv
    tdesktop
    xorg.xev
    zsh-autosuggestions
    font-awesome
    libreoffice
  ];



#fonts.fonts = [ ];

   fonts.fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "Iosevka" "FiraCode" "Hack" ]; })
   ];

   # Mount drive
   security.pam.mount.enable = true;
   security.pam.mount.createMountPoints = true;
   

nix = {
    # Hard link identical files in the store automatically
    autoOptimiseStore = true;
    # automatically trigger garbage collection
    gc.automatic = true;
    gc.dates = "weekly";
    gc.options = "--delete-older-than 30d";
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leavecatenate(variables, "bootdev", bootdev)
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
