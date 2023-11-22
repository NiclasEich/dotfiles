local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
-- see :help lsp-zero-keybindings
-- to learn the available actions
lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    -- Replace the language servers listed here 
    -- with the ones you want to install
    ensure_installed = {'tsserver', 'rust_analyzer', 'pyright', 'lua_ls', 'julials'},
    handlers = {
        lsp_zero.default_setup,
    }
})
require('lspconfig').lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
    },
  },
}

require('lspconfig').rust_analyzer.setup({})
require('lspconfig').pyright.setup({})
require('lspconfig').julials.setup({})
