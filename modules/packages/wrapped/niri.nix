{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... } : {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem = { pkgs, lib, ... }: {

    packages.myNiri = (inputs.wrappers.wrapperModules.niri.apply {
      inherit pkgs;
	settings = let
        startNoctaliaExe = lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia;
        noctaliaExe = lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia;
      in {
        prefer-no-csd = null;

        input = {
          #focus-follows-mouse = null;

          keyboard = {
            xkb = {
              layout = "br";
              variant = "abnt2";
            };
          };

          touchpad = {
	    accel-profile = "flat";
            natural-scroll = null;
            tap = null;
          };

          mouse = {
            accel-profile = "flat";
          };
        };

	

	outputs = {
          "eDP-1" = {
            mode = "1920x1080@60.000";
            scale = 1;
	    position = {
	      _attrs = {
		x = 0;
		y = 0;
	      };
	    };
          };

          "HDMI-A-1" = {
            mode = "1920x1080@120.000";
            scale = 1;
            position = {
	      _attrs = {
		x = 1920;
		y = 0;
	      };
	    };
	    focus-at-startup = null;
          };
        };

        window-rules = [{
          geometry-corner-radius = 12;
          clip-to-geometry = true;
        }];

        binds = {
          "Mod+Backspace".spawn-sh = lib.getExe pkgs.ghostty;
          "Mod+Space".spawn-sh = "${noctaliaExe} ipc call launcher toggle";

          "Mod+Q".close-window = null;
          "Mod+F".maximize-column = null;
          "Mod+G".fullscreen-window = null;
          "Mod+Shift+F".toggle-window-floating = null;
          "Mod+C".center-column = null;

          "Mod+Left".focus-column-left = null;
          "Mod+Right".focus-column-right = null;
          "Mod+Up".focus-window-up = null;
          "Mod+Down".focus-window-down = null;

          "Mod+Shift+Left".move-column-left = null;
          "Mod+Shift+Right".move-column-right = null;
          "Mod+Shift+Up".move-window-up = null;
          "Mod+Shift+Down".move-window-down = null;

          "Mod+1".focus-workspace = "w0";
          "Mod+2".focus-workspace = "w1";
          "Mod+3".focus-workspace = "w2";
          "Mod+4".focus-workspace = "w3";
          "Mod+5".focus-workspace = "w4";
          "Mod+6".focus-workspace = "w5";
          "Mod+7".focus-workspace = "w6";
          "Mod+8".focus-workspace = "w7";
          "Mod+9".focus-workspace = "w8";
          "Mod+0".focus-workspace = "w9";

          "Mod+Shift+1".move-column-to-workspace = "w0";
          "Mod+Shift+2".move-column-to-workspace = "w1";
          "Mod+Shift+3".move-column-to-workspace = "w2";
          "Mod+Shift+4".move-column-to-workspace = "w3";
          "Mod+Shift+5".move-column-to-workspace = "w4";
          "Mod+Shift+6".move-column-to-workspace = "w5";
          "Mod+Shift+7".move-column-to-workspace = "w6";
          "Mod+Shift+8".move-column-to-workspace = "w7";
          "Mod+Shift+9".move-column-to-workspace = "w8";
          "Mod+Shift+0".move-column-to-workspace = "w9";

          #"Mod+V".spawn-sh = ''${pkgs.alsa-utils}/bin/amixer sset Capture toggle'';

          "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+";
          "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-";

          "Mod+Ctrl+Left".set-column-width = "-5%";
          "Mod+Ctrl+Right".set-column-width = "+5%";
          "Mod+Ctrl+Up".set-window-height = "-5%";
          "Mod+Ctrl+Down".set-window-height = "+5%";

          "Mod+Ctrl+S".spawn-sh = ''${lib.getExe pkgs.grim} -l 0 - | ${pkgs.wl-clipboard}/bin/wl-copy'';
          "Mod+Shift+E".spawn-sh = ''${pkgs.wl-clipboard}/bin/wl-paste | ${lib.getExe pkgs.swappy} -f -'';
          "Mod+Shift+S".spawn-sh = lib.getExe (pkgs.writeShellApplication {
            name = "screenshot";
            text = ''
              ${lib.getExe pkgs.grim} -g "$(${lib.getExe pkgs.slurp} -w 0)" - \
              | ${pkgs.wl-clipboard}/bin/wl-copy
            '';
          });

          #"Mod+d".spawn-sh = self.mkWhichKeyExe pkgs [
          #  {
          #    key = "d";
          #    desc = "Discord";
          #    cmd = "vesktop";
          #  }
          #  {
          #    key = "s";
          #    desc = "Pavucontrol";
          #    cmd = "${lib.getExe pkgs.pavucontrol}";
          #  }
          #];
        };

	  layout = {
 	    gaps = 5;
            focus-ring = {
              width = 2;
              #active-color = "#${self.themeNoHash.base09}";
	  };
	};

        xwayland-satellite.path =
          lib.getExe pkgs.xwayland-satellite;

        spawn-at-startup = [
          startNoctaliaExe
	];
        };
    }).wrapper;
  };
}
