-- Autocmds

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Auto-open Neo-tree on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Small delay to ensure everything is loaded
    vim.defer_fn(function()
      vim.cmd("Neotree reveal")
    end, 10)
  end,
})


