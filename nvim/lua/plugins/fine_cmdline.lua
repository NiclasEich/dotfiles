return {
  "VonHeikemen/fine-cmdline.nvim",
  enabled=false,
  dependencies = { "MunifTanjim/nui.nvim" },
  cmd = "FineCmdline",
  init = function()
    vim.keymap.set("n", ":", "<cmd>FineCmdline<CR>", { noremap = true })
  end,
  opts = {
    cmdline = { enable_keymaps = true, smart_history = true, prompt = ": " },
    popup = {
      position = { row = "80%", col = "7%" },
      size     = { width = "50%" },
      border   = { -- style = "rounded",
      },
      win_options = { winhighlight = "Normal:Normal,FloatBorder:FloatBorder" },
    },
    hooks = {
      before_mount = function(_) end,
      after_mount  = function(_) end,
      set_keymaps  = function(_, _) end,
    },
  },
  config = function(_, opts) require("fine-cmdline").setup(opts) end,
}

