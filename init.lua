-- Set leader key (spacebar)
vim.g.mapleader = " "

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Indentation
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Colors
vim.o.termguicolors = true

-- Keymaps
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>")
vim.keymap.set("n", "<leader>sh", ":split<CR>")
