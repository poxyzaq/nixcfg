{ self, inputs, ... } : {
  flake.nixosModules.helium = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.myHelium
    ];
  };

  perSystem = { pkgs, ... } : {
    packages.myHelium = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      flagSeparator = "=";
      flags = {
        "--ozone-platform-hint" = "auto";
        "--enable-features" = "WaylandWindowDecorations";
      };
      env = {
        __NV_PRIME_RENDER_OFFLOAD = "1";
        __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        __VK_LAYER_NV_OPTIMUS = "NVIDIA_only";
      };
      package = inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };
  };
}
