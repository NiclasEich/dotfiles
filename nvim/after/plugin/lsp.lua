vim.lsp.enable('pyright')

vim.diagnostic.config({ virtual_text = true })

vim.lsp.config('rust_analyzer', {
  -- Server-specific settings. See `:help lsp-quickstart`
  settings = {
    ['rust-analyzer'] = {},
  },
})

