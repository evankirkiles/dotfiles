local HOME = os.getenv("HOME")

return {
  -- Syntax highlighting
  -- If highlights.scm becomes broken: `:TSUninstall vim`
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "clojure",
        "css",
        "diff",
        "glsl",
        "graphql",
        "html",
        "ini",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "regex",
        "rust",
        "scss",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "wgsl",
        "yaml",
      })
    end,
  },
  -- LSP context (containing scope beyond top line)
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    opts = {
      mode = "topline",
      max_lines = 3,
    },
  },
  -- Code formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2", "-ci" },
        },
      },
      formatters_by_ft = {
        wgsl = { "wgslfmt" },
        rust = { "rustfmt", lsp_format = "fallback" },
      },
    },
  },
  -- Linting
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          args = { "--config", HOME .. "/.markdownlint-cli2.yaml", "--" },
        },
      },
    },
  },
}
