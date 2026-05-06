{ self, inputs, ... }: {
  flake.wrapperModules.noctalia = inputs.wrappers.lib.wrapModule ./_wrapper.nix;
}
