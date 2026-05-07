{ pkgs, ... }: {
  plugins.lsp = {
    enable = true;

    servers = {
      clangd.enable = true;
      lua_ls.enable = true;
      roslyn_ls.enable = true;
    };

    keymaps = {
      lspBuf = {
        "gd" = "definition";
        "gD" = "declaration";
        "gr" = "references";
        "gi" = "implementation";
        "K" = "hover";
        "<leader>rn" = "rename";
        "<leader>ca" = "code_action";
      };

      diagnostic = {
        "<leader>e" = "open_float";
        "[d" = "goto_prev";
        "]d" = "goto_next";
      };
    };
  };

  plugins.rustaceanvim = {
    enable = true;
  };

  extraPackages = with pkgs; [
    clang-tools
    lua-language-server
    rust-analyzer
  ];
}
