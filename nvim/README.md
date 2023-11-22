# My own NVIM tutorial with keybindings

## General
- <leader>pv - Explorer
- <leader>y - copy to clipboeard
- <leader>s - start search on current word
- <C-d> - half page jump down
- <C-u> - half page jump up

## Telescope:
`~/.config/nvim/after/plugin/telescope.lua`
- <leader>ff - search for files
- <leader>ps - Grep
- <leader>fg - live grep
- <leader>fb - builtin buffers
- <leader>fh - builtin help tags
- <C-p>      - git files

## Harpoon
- <leader>a - mark add file
- <C-e>     - ui toggle menu
- <C-h>     - nav file 1
- <C-t>     - nav file 2
- <C-n>     - nav file 3
- <C-n>     - nav file 4

## Undotree
- <leader>u - show undo tree

## LSP
 - K: Displays hover information about the symbol under the cursor in a floating window. See :help vim.lsp.buf.hover().
 - gd: Jumps to the definition of the symbol under the cursor. See :help vim.lsp.buf.definition().
 - gi: Lists all the implementations for the symbol under the cursor in the quickfix window. See :help vim.lsp.buf.implementation().
 - go: Jumps to the definition of the type of the symbol under the cursor. See :help vim.lsp.buf.type_definition().
 - gr: Lists all the references to the symbol under the cursor in the quickfix window. See :help vim.lsp.buf.references().
 - <F2>: Renames all references to the symbol under the cursor. See :help vim.lsp.buf.rename().
 - <F3>: Format code in current buffer. See :help vim.lsp.buf.format().

 ## Snippetst
  - TAB  -  confirm
  - <C-Space> - toggle completion menu
  - <C-f> - jump forward
  - <C-b> - jump backward
  - <C-u> - scroll docs -4
  - <C-d> - scroll docs +4
