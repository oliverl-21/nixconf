{ self, inputs, ... }: {
  flake.nixosModules.gpc01Configuration = { pkgs, lib, ...}: {
    imports = with self; [
      nixosHardware.gpc01
      nixosModules.preferences
      nixosModules.general
      nixosModules.desktop
    ];
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    boot = {
      loader = {
        systemd-boot.enable = true;
	efi.canTouchEfiVariables = true;
      };
      kernelPackages = pkgs.linuxPackages_latest;
    };
    networking = {
      wireless.enable = false;
      hostName = "gpc01";
      networkmanager.enable = true;
    };
    time.timeZone = "Europe/Berlin";

    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = pkgs.linuxPackages_latest.nvidiaPackages.latest;
    };
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "mac";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
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
  # services.xserver.libinput.enable = true;

  # Install firefox.
  programs.firefox.enable = true;
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };
  programs.tmux = {
    enable = true;
    clock24 = true;
    shortcut = "a";
    baseIndex = 1;
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment = {
    systemPackages = with pkgs; [
      git
      curl
      bitwarden-desktop   
    ];
    sessionVariables = rec {
      SSH_AUTH_SOCK = "$HOME/.bitwarden-ssh-agent.sock";
    };
  };
    system.stateVersion = "25.11";
  };
}

