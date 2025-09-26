-- If you're calling this file from init.vim with:
--   lua require('plugins')
-- this file will bootstrap lazy.nvim and set up your plugins.

-- 1) Bootstrap lazy.nvim (installs to stdpath('data')/lazy/lazy.nvim if missing)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- 2) Plugin specs (translated from your Packer config)
require("lazy").setup("plugins")
