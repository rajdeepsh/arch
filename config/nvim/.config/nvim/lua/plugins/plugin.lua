return {
  { 
    "catppuccin/nvim",
    enabled = false,
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme catppuccin-mocha]])
    end,
  },
  {
    "folke/tokyonight.nvim",
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    ---@type snacks.Config
    opts = {
      notifier = { enabled = true },
      explorer = { enabled = true },
    },
  }
}
