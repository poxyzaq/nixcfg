{ self, inputs, ... }: {
  flake.nixosModules.ghostty = { pkgs, lib, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.myGhostty
    ];
  };

  perSystem = { pkgs, lib, ... } : {
    packages.myGhostty = (inputs.wrappers.wrapperModules.ghostty.apply {
      inherit pkgs;
      settings = {
        font-family = "Annotation Mono";
        font-style = "Medium";
        font-style-bold = "Bold";
        font-style-italic = "Regular Oblique";
        font-style-bold-italic = "Bold Oblique";
        font-size = 12;

        #window-decoration = false;
        window-padding-x = 15;
        window-padding-y = 0;
        background-opacity = 0.95;
        background-blur-radius = 32;

        cursor-style = "block";
        cursor-style-blink = false;

        scrollback-limit = 3023;

        # Terminal
        mouse-hide-while-typing = true;
        copy-on-select = false;
        confirm-close-surface = false;
        app-notifications = "no-clipboard-copy,no-config-reload";

        unfocused-split-opacity = 0.7;

        gtk-titlebar = false;
        gtk-single-instance = true;

        shell-integration = "detect";
        shell-integration-features = "cursor,sudo,title,no-cursor";
      };
    }).wrapper;
  };
}
