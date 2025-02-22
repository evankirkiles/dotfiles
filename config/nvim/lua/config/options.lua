-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- use telescope as the picker
vim.g.lazyvim_picker = "fzf"

-- add a colorcolumn at 80
vim.opt.colorcolumn = "80"

-- set base text width so comments will auto-wrap after this specific length
vim.opt.textwidth = 80
