{ self, inputs, ... } : {
  flake.nixosModules.configuration = { pkgs, lib, ... } : {
    imports = [
      self.nixosModules.hardware
      self.nixosModules.niri
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    nixpkgs.config.allowUnfree = true;
    environment = {
      systemPackages = with pkgs; [
        spotifywm
	vesktop
	firefox
        neovim
        tealdeer
        wget
        curl
        tree
        bat
	git
      ];

      sessionVariables = {
        NIXOS_OZONE_WL = "1";
      };
    };

    services = {
      displayManager = {
	ly.enable = true;
	defaultSession = "niri";
      };

      pipewire = {
	enable = true;
	pulse.enable = true;
      };

      libinput.enable = true;

      xserver.videoDrivers = ["nvidia"];
    };

    fonts.packages = with pkgs; [
      annotation-mono
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos";
    networking.networkmanager.enable = true;

    time.timeZone = "America/Sao_Paulo";
    i18n.defaultLocale = "en_US.UTF-8";
      console = {
      font = "Lat2-Terminus16";
      keyMap = "br-abnt2";
    };

    users.users.poxy = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      packages = with pkgs; [
      ];
    };

    programs = {
      thunar = {
	enable = true;
      };

      gnupg.agent.enable = true;
    };
    
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          intel-media-driver
        ];
      };

      nvidia = {
        modesetting.enable = true;
        powerManagement = {
          enable = false;
          finegrained = false;
        };

        open = false;
        nvidiaSettings = true;

        prime = {
          sync.enable = true;
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";
        };

        package = pkgs.linuxPackages.nvidiaPackages.legacy_580;
        forceFullCompositionPipeline = true;
      };
    };
   
    system.stateVersion = "25.11";
  };
}
