return {
  "tpope/vim-fugitive",
  cmd = { "Git", "G", "Gedit", "Gdiffsplit", "Gvdiffsplit" },
  keys = {
    { "<leader>gs", function() vim.cmd.Git() end, desc = "Fugitive: Git status" },
  },
}

