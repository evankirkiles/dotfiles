-- Command for quickly closing diffview from normal mode
local close_diffview = { "n", "q", "<cmd>DiffviewClose<cr>", desc = "Diffview: Close" }

return {
  -- Nice git interface
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    config = true,
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
    },
  },
  -- Nice diff / 3-way merge interface
  {
    "sindrets/diffview.nvim",
    opts = {
      view = {
        -- Configure the layout and behavior of different types of views.
        -- For more info, see |diffview-config-view.x.layout|.
        merge_tool = {
          -- Config for conflicted files in diff views during a merge or rebase.
          layout = "diff3_mixed",
        },
      },
      keymaps = {
        view = {
          close_diffview,
        },
        file_panel = {
          close_diffview,
        },
        file_history_panel = {
          close_diffview,
        },
      },
    },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview: Open" },
      { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview: File History" },
      { "<leader>gb", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview: Branch History" },
    },
  },
  -- Quick-copy GitHub links directly to real lines in the project
  {
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
    opts = {},
    keys = {
      { "<leader>gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "GitLink: Yank" },
      { "<leader>gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "GitLink: Open" },
    },
  },
}
