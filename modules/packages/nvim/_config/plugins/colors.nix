{ pkgs, ... }:

{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "themeInitNvim";
      src = pkgs.fetchFromGitHub {
        owner = "initsyscall";
        repo = "themeInitNvim";
        rev = "main";
        hash = "sha256-ELWfKB0syc6i6nLhnZ85K9NEAl5E0fPh7dqrfW6T3ag=";
      };
    })
  ];

  extraConfigLua = ''
    require("themeInit").setup({
      theme = "nightSyscall",
      transparent = true,   -- if the theme supports it
    })

    -- Force transparency (recommended)
    local function applyTransparency()
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
      vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
      vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none" })
      vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
      vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
    end

    -- Apply immediately
    applyTransparency()

    -- Re-apply when colorscheme changes (in case of reloads)
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = applyTransparency,
    })
  '';
}
