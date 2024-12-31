return {
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
}
