return {
  {
    "folke/snacks.nvim",
    opts = {
      lazygit = { enabled = false },
      terminal = {
        win = {
          height = 0.25,
        },
      },
    },
    keys = {
      -- Override some bindings that expect LazyGit: https://github.com/folke/snacks.nvim?tab=readme-ov-file#-usage
      { "<leader>gg", false }, -- We're using neogit, not lazygit
      { "<leader>gf", false }, -- We're using neogit, not lazygit
      { "<leader>gl", false }, -- We're using neogit, not lazygit
    },
  },
}