{ config, lib, ... }: {
  _class = "wrapper";

  options.settings = lib.mkOption {
    type = lib.types.attrs;
    default = {};
    description = "noctalia-shell settings.json contents";
  };

  config.package = config.pkgs.noctalia-shell;
  config.env.NOCTALIA_SETTINGS_FILE = "${
    config.pkgs.writeText "settings.json" (builtins.toJSON config.settings)
  }";
}
