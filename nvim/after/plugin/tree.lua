-- https://github.com/nvim-tree/nvim-tree.lua

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  -- vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
  -- vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
  vim.keymap.set('n', '<C-t>', ':NvimTreeToggle<CR>', {noremap=true})
end

require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
   -- on_attach = my_on_attach,
})

--local function restore_nvim_tree()
--  require("nvim-tree.api").tree.open({ focus = false })
--end

--require('auto-session').setup {
--    post_restore_cmds = {restore_nvim_tree}
--}
