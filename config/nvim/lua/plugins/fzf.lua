return {
  { "junegunn/fzf", build = "./install --bin" },
  {
    "fzf-lua",
    opts = {
      previewers = {
        builtin = {
          extensions = {
            ["png"] = { "viu", "-b" },
            ["jpg"] = { "viu", "-b" },
            ["jpeg"] = { "viu", "-b" },
          },
        },
      },
    },
  },
}
