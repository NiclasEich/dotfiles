return {
    {
  "lervag/vimtex",

  -- Load when editing TeX *and* when you call common VimTeX commands
  ft = { "tex", "plaintex" },      -- 'latex' is not a Neovim filetype
  cmd = { "VimtexCompile", "VimtexView", "VimtexTocOpen", "VimtexInfo", "VimtexClean", "VimtexStop" },

  -- VimTeX reads globals at startup; set them in `init` (runs before the plugin loads)
  init = function()
      -- Use Preview.app (open) or Skim; for SyncTeX jumps, prefer Skim:
      -- vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_view_general_viewer = "open"

      -- Compiler backend
      vim.g.vimtex_compiler_method = "latexmk"

      -- 1) Choose LuaLaTeX as the default engine (the VimTeX way)
      --    (You can keep just the "_" entry; the rest are included for clarity.)
      vim.g.vimtex_compiler_latexmk_engines = {
        ["_"]        = "-lualatex", -- default engine for this project
        pdflatex     = "-pdf",
        luatex       = "-lualatex",
        lualatex     = "-lualatex",
        xelatex      = "-xelatex",
        pdfdvi       = "-pdfdvi",
        pdfps        = "-pdfps",
      }

      -- 2) Keep VimTeX's default latexmk options *and* add your shell-escape
      --    Defaults include: -verbose -file-line-error -synctex=1 -interaction=nonstopmode
      --    We repeat them here because setting 'options' replaces the defaults.
      vim.g.vimtex_compiler_latexmk = {
        executable = "latexmk",
        options = {
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
          "-shell-escape",        -- your extra
        },
        -- Optional output dirs (uncomment if you want a build dir):
        -- aux_dir = "build",
        -- out_dir = "build",
      }

      -- Quickfix behaviour and leader
      vim.g.vimtex_quickfix_mode = 0
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
  },
  {
    "let-def/texpresso.vim",
      ft = { "tex", "plaintex" },
      config = function()
        -- :TexpressoStart to start, :TexpressoStop to stop
        -- Bind a quick key:
        vim.keymap.set("n", "<localleader>lx", "<cmd>TexpressoToggle<CR>", { desc = "TeXpresso: Toggle" })
      end,
    }
}
