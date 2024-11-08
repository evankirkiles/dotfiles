return {
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
      },
      setup = {
        rust_analyzer = function()
          return true
        end,
      },
    },
  },
}
