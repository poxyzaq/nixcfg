{ self, inputs, ... }: {
  perSystem = { pkgs, ... }: {
    packages.myNoctalia = (self.wrapperModules.noctalia-shell.apply {
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
