# Neovim keybindings

The leader and local leader are both `\`.

## General

- `<leader>pv` — open netrw
- `<leader>y` — copy to the system clipboard
- `<leader>ss` — replace the word under the cursor
- `<C-d>` / `<C-u>` — half-page movement with cursor centering
- `<C-t>` — toggle nvim-tree
- `<leader>u` — toggle the undo tree

## Telescope

- `<leader>ff` — find files
- `<leader>ps` — grep for entered text
- `<leader>fg` — live grep
- `<leader>fb` — list buffers
- `<leader>fh` — search help tags
- `<leader>fm` — list marks
- `<leader>fc` — select a colorscheme
- `<leader>s` — search the current buffer
- `<C-p>` — find Git-tracked files

## Harpoon

- `<leader>a` — add the current file
- `<C-e>` — open the Harpoon list in Telescope
- `<C-n>` — move to the next Harpoon entry

## LSP

- `K` — hover documentation
- `gl` — line diagnostics
- `<leader>xx` — workspace diagnostics
- `<leader>xX` — buffer diagnostics
- `<leader>cs` — symbols
- `<leader>cl` — LSP definitions and references

## Completion and snippets

- `<C-Space>` — toggle completion
- `<C-f>` / `<C-b>` — move through snippet fields
- `<C-u>` / `<C-d>` — scroll completion documentation

Custom snippets are declared as VS Code-style snippets under `snippets/`.
Plugin revisions are pinned in `lazy-lock.json`.
