return {
  "chentoast/marks.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    default_mappings = true,
    cyclic = true,
    force_write_shada = false,
    refresh_interval = 150,
    excluded_filetypes = {},
    excluded_buftypes = {},
    mappings = {
      set_next      = "m,",
      next          = "<leader>m",
      preview       = "m:",
      set_bookmark0 = "m0",
      prev          = false, -- disable only this default mapping
    },
    -- sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
  },
  config = function(_, opts) require("marks").setup(opts) end,
}

