return {
  -- Code symbols outline pane (<leader>cs)
  {
    "stevearc/aerial.nvim",
    opts = {
      layout = {
        default_direction = "right",
        min_width = 40,
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        hover = {
          silent = true,
        },
      },
    },
  },
  -- Modify some defaults of LazyVim / snacks
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = { hidden = true },
          grep = { hidden = true },
          explorer = { hidden = true },
        },
      },
      lazygit = { enabled = false },
      scroll = { enabled = false },
      terminal = { enabled = false },
      scratch = { ft = "markdown" },
    },
    keys = {
      -- Override some bindings that expect LazyGit: https://github.com/folke/snacks.nvim?tab=readme-ov-file#-usage
      { "<leader>gg", false }, -- We're using neogit, not lazygit
      { "<leader>gf", false }, -- We're using neogit, not lazygit
      { "<leader>gl", false }, -- We're using neogit, not lazygit
    },
  },
  -- Left tree view of file structure
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_by_name = {
            ".DS_Store",
          },
          never_show = {
            ".git",
          },
        },
        bind_to_cwd = false,
        group_empty_dirs = true,
        follow_current_file = { enabled = true },
      },
    },
  },
  -- Bottom status bar in nvim interface
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Remove the LSP location in lualine, it's annoying and poorly formatted
      table.remove(opts.sections.lualine_c)
      --- Remove the time from lualine (we have time in tmux)
      opts.sections.lualine_z = { "lsp_status" }
      return opts
    end,
  },
  -- Autosuggest menu
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
      },
    },
  },
  -- Claude integration
  {
    "coder/claudecode.nvim",
    opts = {
      diff_opts = {
        open_in_new_tab = true,
      },
      terminal = {
        provider = "none", -- no UI actions; server + tools remain available
      },
    },
  },
}
