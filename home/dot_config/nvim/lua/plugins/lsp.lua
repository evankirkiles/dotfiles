return {
  -- General LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = true,
        severity_sort = true,
        virtual_text = true,
        float = {
          source = "always",
        },
        signs = true,
      },
      servers = {
        wgsl_analyzer = {},
        graphql = {},
        cssls = {},
        clojure_lsp = {},
        tailwindcss = {
          settings = {
            tailwindCSS = {
              classFunctions = {
                "tw",
                "clsx",
                "cx",
                "cva",
              },
            },
          },
        },
      },
      inlay_hints = {
        enabled = false,
      },
      setup = {
        rust_analyzer = function()
          return true
        end,
      },
    },
  },
  -- Installer for additional language server binaries
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "wgsl-analyzer",
        "graphql-language-service-cli",
        "css-lsp",
      },
    },
  },
  -- Kitty configuration file integration
  { "fladson/vim-kitty", ft = "kitty", lazy = true },
  -- Rust LSP configuration
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
  },
}
