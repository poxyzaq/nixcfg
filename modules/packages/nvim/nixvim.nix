{ self, inputs, ... }:

{
  flake.nixosModules.nvim = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.nvim
    ];

    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    environment.shellAliases = {
      vim = "nvim";
    };
  };

  perSystem = { pkgs, system, ... }:

    let
      nvim = inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule {
        module = inputs.import-tree ./_config;
      };
    in
    {
      packages.nvim = nvim;
      packages.default = nvim;
    };
}
