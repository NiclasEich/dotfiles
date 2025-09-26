return {
  "lervag/vimtex",

  -- Load when editing TeX *and* when you call common VimTeX commands
  ft = { "tex", "plaintex" },      -- 'latex' is not a Neovim filetype
  cmd = { "VimtexCompile", "VimtexView", "VimtexTocOpen", "VimtexInfo", "VimtexClean", "VimtexStop" },

  -- VimTeX reads globals at startup; set them in `init` (runs before the plugin loads)
  init = function()
    -- Viewer (macOS): Skim is a great default. Install: `brew install --cask skim`
    vim.g.vimtex_view_method = "skim"

    -- Compiler: latexmk (bundled with MacTeX; or `brew install latexmk`)
    vim.g.vimtex_compiler_method = "latexmk"
    -- Optional latexmk tuning example:
    -- vim.g.vimtex_compiler_latexmk = { options = { "-pdf", "-shell-escape", "-verbose" } }

    -- Quickfix behavior (0 = open only on errors)
    vim.g.vimtex_quickfix_mode = 0

    -- If you use localleader for VimTeX mappings, ensure it's set early
    vim.g.maplocalleader = "\\"
  end,

  -- Handy keymaps that also lazy-load the plugin on first use
  keys = {
    { "<localleader>ll", "<cmd>VimtexCompile<cr>", desc = "VimTeX: Compile" },
    { "<localleader>lv", "<cmd>VimtexView<cr>",    desc = "VimTeX: View PDF" },
    { "<localleader>lk", "<cmd>VimtexStop<cr>",    desc = "VimTeX: Stop" },
    { "<localleader>li", "<cmd>VimtexInfo<cr>",    desc = "VimTeX: Info" },
    { "<localleader>lt", "<cmd>VimtexTocOpen<cr>", desc = "VimTeX: TOC" },
  },
}

