vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
-- und das robustere Verzeichnis:
local undodir = vim.fn.stdpath('state') .. '/undo'
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, 'p', 0700)
end

vim.opt.undodir = undodir
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

local function set_diff_change_hl()
  local colors = require("tokyonight.colors").setup()
  local util = require("tokyonight.util")
  vim.api.nvim_set_hl(0, "DiffChange", { bg = util.darken(colors.diff.text, 0.35) })
end

local diff_hl_group = vim.api.nvim_create_augroup("DiffHighlights", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  group = diff_hl_group,
  pattern = "tokyonight-moon",
  callback = set_diff_change_hl,
})

if vim.g.colors_name == "tokyonight-moon" then
  set_diff_change_hl()
end
