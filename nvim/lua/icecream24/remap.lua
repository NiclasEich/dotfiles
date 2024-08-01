vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- commenting
vim.keymap.set("n", "<leader>cc", "<cmd>CommentToggle<CR>")

-- make things move when highlighted
vim.keymap.set("v", "J", ":m  '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m  '>-2<CR>gv=gv")

-- half page jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- copy to clipboard via leader
vim.keymap.set("n", "<Leader>y", "\"+y")
vim.keymap.set("v", "<Leader>y", "\"*y")
vim.keymap.set("n", "<Leader>Y", "\"+Y")
--
-- delette to void with out overwriting
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")
--
-- paste without losing copied thing in buffer
vim.keymap.set("x", "<leader>p", "\"_dP")

-- keep cursor in the middle while searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- nvim-tree toggle
vim.keymap.set("n", "<C-t>", ":NvimTreeToggle<CR>")

-- FlyAway
vim.keymap.set("n", "<leader>f", ":FlyAwayFast push<CR>")

-- search like a madman 
-- not working smh :(
-- vim.keymap.set("n","<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- search for current wors
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
