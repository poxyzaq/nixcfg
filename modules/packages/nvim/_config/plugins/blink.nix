{ ... }: {
  plugins.blink-cmp = {
    enable = true;
    settings = {
      keymap.preset = "default";
      appearance = {
        nerd_font_variant = "mono";
      };
      sources.default = [ "lsp" "path" "buffer" "snippets" ];
      signature.enabled = true;
    };
  };
}
