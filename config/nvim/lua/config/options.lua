-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- use telescope as the picker
vim.g.lazyvim_picker = "fzf"

-- add in a column at 100 chars by default
vim.o.colorcolumn = "+1"
