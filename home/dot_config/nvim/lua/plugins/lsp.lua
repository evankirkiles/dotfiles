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
        clojure_lsp = {},
        graphql = {},
        cssls = {},
        biome = {},
        eslint = {
          settings = {
            useFlatConfig = true,
          },
        }
      },
      inlay_hints = {
        enabled = false,
      },
      setup = {
        rust_analyzer = function()
          return true
        end,
        eslint = function()
          vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = { "*.ts", "*.tsx", "*.js", "*.jsx", "*.mjs" },
            callback = function()
              vim.cmd("LspEslintFixAll")
            end,
          })
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
        "wgsl-analyzer",
        "flake8",
        "rust-analyzer",
        "graphql-language-service-cli",
        "css-lsp",
      },
    },
  },
  -- Rust LSP configuration
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
  },
}
