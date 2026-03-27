local map = vim.keymap.set

map("n", "<leader>e", function()
  require("snacks").explorer({ toggle = true })
end, { desc = "Explorer" })

