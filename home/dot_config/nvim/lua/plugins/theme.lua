return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
    },
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = {
      theme = "dragon",
      background = {
        dark = "dragon",
        light = "lotus",
      },
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
    },
  },
  {
    "cormacrelf/dark-notify",
    event = "VeryLazy",
    enabled = vim.fn.has("macunix"),
    priority = 999,
    config = function(_, opts)
      require("dark_notify").run(opts)
    end,
  },
  { "nvim-tree/nvim-web-devicons", opts = {} },
}
