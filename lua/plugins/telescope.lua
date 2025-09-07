return {
  {
    "nvim-telescope/telescope.nvim",
    version = false,
    dependencies = { "nvim-lua/plenary.nvim", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
      { "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Live grep" },
      { "<leader>sd", function()
        local tb = require("telescope.builtin")
        local has_diag = not vim.tbl_isempty(vim.diagnostic.get(nil))
        if has_diag then tb.diagnostics({}) else tb.diagnostics({ bufnr = 0 }) end
      end, desc = "Diagnostics (workspace/buffer)" },
      { "<C-p>", function() require("telescope.builtin").find_files() end, desc = "Find files (VSCode)" },
    },
    opts = function()
      local actions = require("telescope.actions")
      return {
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
        },
        pickers = {
          find_files = { hidden = true },
        },
        extensions = { fzf = { case_mode = "smart_case", fuzzy = true, override_file_sorter = true, override_generic_sorter = true } },
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      pcall(telescope.load_extension, "fzf")
    end,
  },
}


