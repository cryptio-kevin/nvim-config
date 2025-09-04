-- Leader
vim.g.mapleader = " "

-- Core config
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Plugins
require("config.lazy")
