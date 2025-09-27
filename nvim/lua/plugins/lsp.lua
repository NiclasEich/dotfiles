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

  -- LSP (new Neovim 0.11+ API; no require('lspconfig') framework calls)
  {
    "neovim/nvim-lspconfig",
    lazy = false,           -- <— load at startup so servers attach even during session restore
    dependencies = {
      "saghen/blink.cmp",
      "folke/trouble.nvim",
      "nvimdev/lspsaga.nvim",
      "barreiroleo/ltex_extra.nvim",
    },
    config = function()
      -- Always derive capabilities from blink.cmp
      local function with_caps(cfg)
        cfg = cfg or {}
        cfg.capabilities = require("blink.cmp").get_lsp_capabilities(cfg.capabilities)
        return cfg
      end

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

      -- LTeX+ (Grammar/Spell) — make sure ltex-ls-plus is installed & on PATH
      vim.lsp.config("ltex_plus", with_caps({
        -- If needed, force the binary (uncomment next line):
        -- cmd = { "ltex-ls-plus" },
        settings = {
          ltex = {
            language = "en-US",
            additionalRules = { enablePickyRules = true },
          },
        },
        on_attach = function(_, _)
            local ok, ltex_extra = pcall(require, "ltex_extra")
            if ok and type(ltex_extra) == "table" and ltex_extra.setup then
                ltex_extra.setup({
                    load_langs = { "en-US" },
                    path = vim.fn.stdpath("config") .. "/ltex",
                })
            end
        end,

      }))
      vim.lsp.enable("ltex_plus")

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
      require("lspsaga").setup({})
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

      vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>",
        { desc = "Diagnostics (Trouble)" })

      vim.diagnostic.config({
        virtual_text = false,
        float = { border = "rounded", source = "if_many" },
        severity_sort = true,
      })

      -- Show diag float on hold (correct API shape)
      local diag_float_grp = vim.api.nvim_create_augroup("DiagFloat", { clear = true })
      vim.o.updatetime = 300
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = diag_float_grp,
        callback = function()
          vim.diagnostic.open_float(nil, { focusable = false, border = "rounded", scope = "line" })
        end,
      })
    end,
  },
}

