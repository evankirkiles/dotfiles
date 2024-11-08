return {
  -- add tokyonight
  { "folke/tokyonight.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },

  {
    "SyedFasiuddin/theme-toggle-nvim",
    opts = {
      colorscheme = {
        light = "tokyonight-day",
        dark = "tokyonight-night",
      },
    },
  },
}
