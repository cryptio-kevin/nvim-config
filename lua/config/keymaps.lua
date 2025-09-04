-- Keymaps

local map = vim.keymap.set
local default_opts = { silent = true }

map("n", "<leader>sv", ":vsplit<CR>", default_opts)
map("n", "<leader>sh", ":split<CR>", default_opts)


