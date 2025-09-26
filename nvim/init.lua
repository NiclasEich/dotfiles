require("config.lazy")
require("config.remap")
require("config.init")
require("config.colorscheme")
require("config.set")
print("hello, this is your init.lua speaking")
--require('plugins')
--require("lazy").setup("plugins")
vim.cmd.colorscheme("tokyonight-moon")

-- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
--require("nvim-tree").setup()
--
---- OR setup with some options
--require("nvim-tree").setup({
--  sort = {
--    sorter = "case_sensitive",
--  },
--  view = {
--    width = 30,
--  },
--  renderer = {
--    group_empty = true,
--  },
--  filters = {
--    dotfiles = true,
--  },
--})
