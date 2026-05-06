{ self, inputs, ... }: {
  flake.wrapperModules.noctalia-shell = inputs.wrappers.lib.wrapModule ./_wrapper.nix;
}
