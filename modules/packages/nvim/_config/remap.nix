{ ... }: {
  globals.mapleader = " ";

  keymaps = [
    # Move selected text in visual mode
    { mode = "v"; key = "J"; action = ":m '>+1<CR>gv=gv"; }
    { mode = "v"; key = "K"; action = ":m '<-2<CR>gv=gv"; }

    # Grab line above, maintain cursor position
    { mode = "n"; key = "J"; action = "mzJ`z"; }
    { mode = "n"; key = "<C-d>"; action = "<C-d>zz"; }
    { mode = "n"; key = "<C-u>"; action = "<C-u>zz"; }
    { mode = "n"; key = "n"; action = "nzzzv"; }
    { mode = "n"; key = "N"; action = "Nzzzv"; }

    # Paste without overwriting register
    { mode = "x"; key = "<leader>p"; action = "\"_dP"; }

    # Yank to system clipboard
    { mode = ["n" "v"]; key = "<leader>y"; action = "\"+y"; }
    { mode = "n"; key = "<leader>Y"; action = "\"+Y"; }

    # Delete to void register
    { mode = ["n" "v"]; key = "<leader>d"; action = "\"_d"; }

    # Ctrl+C as Esc
    { mode = "i"; key = "<C-c>"; action = "<Esc>"; }

    # Disable Q
    { mode = "n"; key = "Q"; action = "<nop>"; }

    # LSP format
    { mode = "n"; key = "<leader>ff"; action.__raw = "vim.lsp.buf.format"; }

    # Quickfix navigation
    { mode = "n"; key = "<C-k>"; action = "<cmd>cnext<CR>zz"; }
    { mode = "n"; key = "<C-j>"; action = "<cmd>cprev<CR>zz"; }
    { mode = "n"; key = "<leader>k"; action = "<cmd>lnext<CR>zz"; }
    { mode = "n"; key = "<leader>j"; action = "<cmd>lprev<CR>zz"; }

    # Search and replace word under cursor
    { mode = "n"; key = "<leader>sr"; action = ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>"; }

    # VimBeGood
    { mode = "n"; key = "<leader>bg"; action.__raw = "vim.cmd.VimBeGood"; }

    # Oil
    { mode = "n"; key = "-"; action = "<CMD>Oil<CR>"; options.desc = "Open parent directory"; }
  ]; 
}
