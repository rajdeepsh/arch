return {
  {
    "folke/tokyonight.nvim",
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
      indent = { enabled = true },
      lazygit = { enabled = true },
    },
    keys = {
      { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
      { "<C-g>", function() Snacks.lazygit() end, desc = "Lazygit" },
    },
  }
}
