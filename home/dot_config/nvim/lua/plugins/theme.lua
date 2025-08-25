return {
  -- Set LazyVim colorscheme
  { "LazyVim/LazyVim", opts = { colorscheme = "kanagawa" } },
  -- Nice web icons for neo-tree
  { "nvim-tree/nvim-web-devicons", opts = {} },
  -- Keep neovim theme in sync with system
  {
    "cormacrelf/dark-notify",
    event = "VeryLazy",
    enabled = vim.fn.has("macunix"),
    priority = 999,
    config = function(_, opts)
      require("dark_notify").run(opts)
    end,
  },
  -- Kanagawa color theme (dragon, lotus)
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
}
