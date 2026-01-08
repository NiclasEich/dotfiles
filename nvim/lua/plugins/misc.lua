return {
  -- ── Core libs ─────────────────────────────────────────────────────────────────
  { "nvim-lua/plenary.nvim" },

  -- ── Command line UI ─────────────────────────────────────────────────────────

  -- ── Colorschemes (not auto-applied) ─────────────────────────────────────────
  -- If you want one of these as default, see the commented example below.
  { "rebelot/kanagawa.nvim", name = "kanagawa" },
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup({
        style = "moon",
        on_highlights = function(hl, c)
          local util = require("tokyonight.util")
          hl.CursorLineNr = { fg = util.lighten(c.fg_gutter, 0.5), bold = false }
          hl.LineNrAbove = { fg = util.darken(c.fg_gutter, 0.65) }
        end,
      })
      vim.cmd.colorscheme("tokyonight-moon")
    end,
  },

  -- ── Editing niceties ────────────────────────────────────────────────────────
  {
    "kylechui/nvim-surround",
    version = "*",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  { "folke/zen-mode.nvim", config = function() require("zen-mode").setup() end },
  { "Hashino/doing.nvim" },
  { "NiclasEich/FlyAway" },

  -- ── Rust ────────────────────────────────────────────────────────────────────
  { "rust-lang/rust.vim", ft = { "rust" } },

  -- ── Comments, Marks, Sessions ───────────────────────────────────────────────
  { "numToStr/Comment.nvim", config = function() require("Comment").setup() end },
  {
    "rmagatti/auto-session",
    config = function(_, opts)
      require("auto-session").setup(opts)
    end,
    opts = {
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    },
  },

  -- ── (Optional) Heirline – was commented out in your Packer file ─────────────
  -- {
  --   "rebelot/heirline.nvim",
  --   event = "UIEnter",
  --   config = function()
  --     require("heirline").setup()
  --   end,
  -- },
  }
