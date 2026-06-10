-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.colorcolumn = "80"
vim.opt.textwidth = 80
vim.opt.numberwidth = 4
vim.wo.relativenumber = false

-- No mini snippets in completion
vim.g.lazyvim_mini_snippets_in_completion = true

-- over SSH, force OSC52 clipboard management
vim.opt.clipboard = "unnamedplus"
if vim.env.SSH_TTY then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }
end
