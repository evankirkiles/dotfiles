-- Command for quickly closing diffview from normal mode
local close_diffview = { "n", "q", "<cmd>DiffviewClose<cr>", desc = "Diffview: Close" }

return {
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
}
