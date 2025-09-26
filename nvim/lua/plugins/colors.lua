return {
  "rebelot/kanagawa.nvim",
  name = "kanagawa",
  -- lazy = false; priority = 1000,  -- uncomment with config below if you want to enable at startup
  opts = {
    overrides = function(colors)
      local theme = colors.theme

      -- your first overrides block (floats and “dark” normal)
      local common = {
        NormalFloat = { bg = "none" },
        FloatBorder = { bg = "none" },
        FloatTitle  = { bg = "none" },
        NormalDark  = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
        LazyNormal  = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
      }

      -- your second overrides block (Telescope)
      local telescope = {
        TelescopeTitle         = { fg = theme.ui.special, bold = true },
        TelescopePromptNormal  = { bg = theme.ui.bg_p1 },
        TelescopePromptBorder  = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
        TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
        TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
        TelescopePreviewNormal = { bg = theme.ui.bg_dim },
        TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
      }

      return vim.tbl_extend("force", common, telescope)
    end,
  },

  -- If you want to *enable* Kanagawa at startup, uncomment this block:
  -- lazy = false,
  -- priority = 1000,
  -- config = function(_, opts)
  --   require("kanagawa").setup(opts)
  --   vim.cmd.colorscheme("kanagawa-wave")
  -- end,
}

