return {
  {
    "williamboman/mason.nvim",
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
}
