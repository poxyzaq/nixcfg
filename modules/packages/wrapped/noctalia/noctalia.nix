{ self, inputs, ... }: {
  flake.nixosModules.noctalia = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia
    ];
  };

  perSystem = { pkgs, ... }: {
    packages.myNoctalia = (self.wrapperModules.noctalia.apply {
      inherit pkgs;
      settings = builtins.fromJSON (builtins.readFile ./settings.json);
    }).wrapper;

    packages.setMyNoctalia = pkgs.writeShellApplication {
  name = "set-my-noctalia";
  runtimeInputs = [ pkgs.noctalia-shell pkgs.jq ];
  text = ''
    ${pkgs.noctalia-shell}/bin/noctalia-shell ipc call state all | jq .settings > ~/nixcfg/modules/packages/wrapped/noctalia/settings.json
  '';
};
  };
}
