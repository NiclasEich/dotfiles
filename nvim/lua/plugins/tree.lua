return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  keys = {
    { "<C-t>", "<cmd>NvimTreeToggle<cr>", desc = "NvimTree Toggle" },
  },
  opts = {
    sort = { sorter = "case_sensitive" },
    view = { width = 30 },
    renderer = { group_empty = true },
    filters  = { dotfiles = true },
    -- on_attach = my_on_attach, -- if you decide to revive your custom on_attach
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)
  end,
}

