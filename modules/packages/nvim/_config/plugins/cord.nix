{ pkgs, ... }:

let
  cordBinary = pkgs.runCommand "cord" {} ''
    install -m755 ${pkgs.fetchurl {
      url = "https://github.com/vyfor/cord.nvim/releases/download/v2.3.20/x86_64-linux-cord";
      hash = "sha256:0i4c9nxpqpaiklwmprfyg3n69a7dfcr632m3z82mbqkkqzqyf8i1";
    }} $out
  '';
in
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "cord-nvim";
      doCheck = false;
      src = builtins.fetchTarball {
        url = "https://github.com/vyfor/cord.nvim/archive/refs/tags/v2.3.20.tar.gz";
        sha256 = "0ffmw38y0s01ghsxgj2jxbsfd5nj8pmpnwqhy8xmncpd4g6xr4zm";
      };
    })
  ];

  extraConfigLua = ''
    require("cord").setup({
      enabled = true,
      log_level = vim.log.levels.OFF,
      editor = {
        client = 'neovim',
        tooltip = 'DOYOUFEELTHEWEIGHTOFYOURSINSDOESITHURTDOESGODSJUDGEMENTFILLYOUWITHGUILTTORMENT',
        icon = 'https://media.tenor.com/sAsel0NXnZYAAAAi/raccoon-spinning.gif',
      },
      display = {
        theme = 'atom',
        flavor = 'dark',
        view = 'full',
        swap_fields = true,
        swap_icons = true,
      },
      timestamp = {
        enabled = true,
        reset_on_idle = false,
        reset_on_change = false,
        shared = false,
      },
      idle = {
        enabled = true,
        timeout = 300000,
        show_status = true,
        ignore_focus = true,
        unidle_on_focus = true,
        smart_idle = true,
        details = 'Idling',
        tooltip = '💤',
      },
      text = {
        workspace = function(opts) return 'In ' .. opts.workspace end,
        viewing = function(opts) return 'Viewing ' .. opts.filename end,
        editing = function(opts) return 'Editing ' .. opts.filename end,
        file_browser = function(opts) return 'Browsing files in ' .. opts.name end,
        plugin_manager = function(opts) return 'Managing plugins in ' .. opts.name end,
        lsp = function(opts) return 'Configuring LSP in ' .. opts.name end,
        docs = function(opts) return 'Reading ' .. opts.name end,
        vcs = function(opts) return 'Committing changes in ' .. opts.name end,
        notes = function(opts) return 'Taking notes in ' .. opts.name end,
        debug = function(opts) return 'Debugging in ' .. opts.name end,
        test = function(opts) return 'Testing in ' .. opts.name end,
        diagnostics = function(opts) return 'Fixing problems in ' .. opts.name end,
        games = function(opts) return 'Playing ' .. opts.name end,
        terminal = function(opts) return 'Running commands in ' .. opts.name end,
        dashboard = 'Home',
      },
      advanced = {
        server = {
          executable_path = '${cordBinary}',
        },
      },
    })
  '';
}
