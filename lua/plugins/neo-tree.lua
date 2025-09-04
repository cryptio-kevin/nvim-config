return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = { "Neotree" },
    keys = {
      { "<leader>e", function() vim.cmd("Neotree reveal toggle") end, desc = "Explorer (Neo-tree)" },
    },
    opts = {
      filesystem = { follow_current_file = { enabled = true } },
      default_component_configs = { indent = { with_markers = false } },
    },
  },
}


