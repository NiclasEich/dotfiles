return {
  "github/copilot.vim",
  event = "InsertEnter",
  init = function()
    -- Your globals
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_hide_during_completion = false
    vim.g.copilot_proxy_strict_ssl = false
    vim.g.copilot_settings = { selectedCompletionModel = "gpt-4.1-copilot" }
    vim.g.copilot_filetypes = { rust = false } -- disable Copilot in Rust buffers

    -- Your accept mapping
    vim.keymap.set("i", "<S-Tab>", 'copilot#Accept("\\<S-Tab>")', {
      expr = true, replace_keycodes = false,
    })
  end,
}

