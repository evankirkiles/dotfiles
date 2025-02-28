return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
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
}
