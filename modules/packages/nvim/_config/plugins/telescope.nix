{ ... }: {
  plugins.telescope = {
  enable = true;

  settings = {
    defaults = {
      file_ignore_patterns = [ "%__virtual.cs$" ];
    };
  };

  keymaps = {
    "<leader>pf" = "find_files";
    "<leader>pg" = "live_grep";
    "<C-p>"      = "git_files";
  };
};
}
