-- LSP, completion, snippets, diagnostics, and related UI
return {
  -- Completion engine: blink.cmp
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      keymap = { preset = "default" },
      appearance = { nerd_font_variant = "mono" },
      completion = { documentation = { auto_show = false } },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },

  -- Snippets (LuaSnip) + load your snippets & friendly-snippets
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    opts = { history = true, updateevents = "TextChanged,TextChangedI" },
    config = function(_, opts)
      local ls = require("luasnip")
      ls.config.set_config(opts)
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/snippets" },
      })
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- Optional: extra LaTeX snippets (replaces the old cmp-latex-symbols source)
  {
    "iurimateus/luasnip-latex-snippets.nvim",
    ft = { "tex", "plaintex" },
    dependencies = { "L3MON4D3/LuaSnip" },
    config = function() require("luasnip-latex-snippets").setup() end,
  },
    {
      "folke/trouble.nvim",
      opts = {}, -- for default options, refer to the configuration section for custom setup.
      cmd = "Trouble",
      keys = {
        {
          "<leader>xx",
          "<cmd>Trouble diagnostics toggle<cr>",
          desc = "Diagnostics (Trouble)",
        },
        {
          "<leader>xX",
          "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
          desc = "Buffer Diagnostics (Trouble)",
        },
        {
          "<leader>cs",
          "<cmd>Trouble symbols toggle focus=false<cr>",
          desc = "Symbols (Trouble)",
        },
        {
          "<leader>cl",
          "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
          desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
          "<leader>xL",
          "<cmd>Trouble loclist toggle<cr>",
          desc = "Location List (Trouble)",
        },
        {
          "<leader>xQ",
          "<cmd>Trouble qflist toggle<cr>",
          desc = "Quickfix List (Trouble)",
        },
      },
    },
  -- LSP (new Neovim 0.11+ API; no require('lspconfig') framework calls)
  {
    "neovim/nvim-lspconfig",
    lazy = false,           -- <— load at startup so servers attach even during session restore
    dependencies = {
      "saghen/blink.cmp",
      "folke/trouble.nvim",
      "nvimdev/lspsaga.nvim",
    },
    config = function()
      -- Always derive capabilities from blink.cmp
      local function with_caps(cfg)
        cfg = cfg or {}
        cfg.capabilities = require("blink.cmp").get_lsp_capabilities(cfg.capabilities)
        return cfg
      end
      vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<cr>', opts)

      ---------------------------------------------------------------------------
      -- Servers you want enabled
      ---------------------------------------------------------------------------

      -- Lua
      vim.lsp.config("lua_ls", with_caps({
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      }))
      vim.lsp.enable("lua_ls")

      -- Python (Pyright)
      vim.lsp.config("pyright", with_caps({
          settings = {
              python = {
                  analysis = {
                      -- "off" | "basic" | "strict"
                      typeCheckingMode = "basic",         -- try "strict" if you want more
                      diagnosticMode = "workspace",       -- analyze across workspace, not just open files
                      autoImportCompletions = true,
                      useLibraryCodeForTypes = true,
                      diagnosticSeverityOverrides = {
                          reportUnusedImport = "warning",
                          reportUnusedVariable = "warning",
                          reportMissingImports = "error",
                          reportPrivateImportUsage = "warning",
                          -- add more overrides if you want
                      },
                  },
              },
          },
      }))
      vim.lsp.enable("pyright")

      -- Rust (rust-analyzer)
      vim.lsp.config("rust_analyzer", with_caps({
        settings = { ["rust-analyzer"] = {} },
      }))
      vim.lsp.enable("rust_analyzer")

      -- LTeX (+) — Grammar/Spell
      vim.lsp.config("ltex", with_caps({
          -- Run the LTeX+ binary but keep the client name "ltex"
          cmd = { "ltex-ls-plus" },  -- ensure it's on PATH (e.g., via Mason)
          filetypes = {
              "markdown", "text", "gitcommit", "mail",
              "tex", "plaintex", "bib", "rnoweb", "quarto", "typst", "rst", "org", "pandoc",
          },
          settings = {
              ltex = {
                  language = "en-US",
                  additionalRules = { enablePickyRules = true },
              },
          },
          on_attach = function(client, bufnr)
              local ok, ltex_extra = pcall(require, "ltex_extra")
              if ok then
                  ltex_extra.setup({
                      load_langs = { "en-US" },
                      path = vim.fn.stdpath("config") .. "/ltex",
                      -- optional, tone down notifications from the plugin
                      log_level = "warn",
                  })
              end
          end,
      }))
      vim.lsp.enable("ltex")


      -- TeX (Texlab) — let VimTeX handle build/view; Texlab for LSP features
      vim.lsp.config("texlab", with_caps({
        settings = {
          texlab = {
            build = { onSave = false },
            forwardSearchAfter = false,
            chktex = { onOpenAndSave = true, onEdit = false },
            latexFormatter = "latexindent",
            latexindent = { modifyLineBreaks = false },
            inlayHints = { labelDefinitions = true, labelReferences = true },
          },
        },
      }))
      vim.lsp.enable("texlab")

      ---------------------------------------------------------------------------
      -- UI niceties & diagnostics
      ---------------------------------------------------------------------------
      require("lspsaga").setup({
        ui = {
            code_action = '🔍',
            lightbulb = { enable = false },  -- stop auto code-action probing per cursor
        }
      })
      vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")
      vim.keymap.set("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "Line diagnostics (Saga)" })


      -- Optional: auto-show via Saga on CursorHold in normal mode
      vim.o.updatetime = 2000
      vim.api.nvim_create_autocmd("CursorHold", {
          group = diag_float_grp,
          callback = function()
              vim.cmd("Lspsaga show_cursor_diagnostics ++unfocus")
          end,
      })

      vim.diagnostic.config({
        virtual_text = false,
        float = { border = "rounded", source = "if_many" },
        severity_sort = true,
      })

      -- Show diag float on hold (correct API shape)
      --local diag_float_grp = vim.api.nvim_create_augroup("DiagFloat", { clear = true })
      --vim.o.updatetime = 300
      --vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      --  group = diag_float_grp,
      --  callback = function()
      --    vim.diagnostic.open_float(nil, { focusable = false, border = "rounded", scope = "line" })
      --  end,
      --})
    end,
  },
}
