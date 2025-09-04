return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm" },
    keys = {
      { "<C-`>", function() require("toggleterm").toggle(1) end, desc = "Toggle terminal" },
    },
    opts = {
      open_mapping = [[<c-`>]],
      direction = "float",
      float_opts = { border = "single" },
      size = 15,
    },
  },
}


