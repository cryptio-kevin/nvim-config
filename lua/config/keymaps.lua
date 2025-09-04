-- Keymaps

local map = vim.keymap.set
local default_opts = { silent = true }

map("n", "<leader>sv", ":vsplit<CR>", default_opts)
map("n", "<leader>sh", ":split<CR>", default_opts)

-- VSCode-like
map("n", "<C-b>", function() vim.cmd("Neotree reveal toggle") end, { desc = "Explorer" })
map("n", "<C-\\>", ":split<CR>", { silent = true, desc = "Split horizontal" })
map("n", "<C-=>", ":vsplit<CR>", { silent = true, desc = "Split vertical" })
map("n", "<C-Tab>", ":bnext<CR>", { silent = true, desc = "Next buffer" })
map("n", "<C-S-Tab>", ":bprevious<CR>", { silent = true, desc = "Prev buffer" })

-- Move lines (VSCode-like Alt/Option+j/k)
map("n", "<A-j>", ":m .+1<CR>==", { silent = true, desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { silent = true, desc = "Move line up" })
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { silent = true, desc = "Move line down" })
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { silent = true, desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })



