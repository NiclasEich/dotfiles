require('telescope').setup{
  pickers = {
    find_files = {
      --theme = "dropdown",
    }
  }
}
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fm', builtin.marks, {})
vim.keymap.set('n', '<leader>fc', builtin.colorscheme, {})


vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input( "Grep > ")})
end)

-- In init.lua (oder irgendeiner anderen geladenen Lua-Datei)
vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find{
    -- immer fuzzymatchen, aber OHNE Beachtung von Groß-/Kleinschreibung
    case_mode = 'ignore_case',   -- Alternativen: 'smart_case', 'respect_case'
    -- ein paar optionale Layout-Tweaks
    previewer = false,
    layout_config = { width = 0.5 },
  }
end, { desc = 'Suche im aktuellen Buffer (case-insensitive)' })

vim.keymap.set('n', '<leader>s', function()
  local word = vim.fn.expand('<cword>')      -- Wort unter dem Cursor holen
  require('telescope.builtin').current_buffer_fuzzy_find{
    default_text = word,                     -- schon vorausgefülltes Input-Feld
    case_mode    = 'ignore_case',            -- dauerhaft case-insensitiv
    previewer    = false,
    layout_config = { width = 0.5 },
  }
end, { desc = 'Buffer-Suche nach Wort unter Cursor (case-insensitiv)' })
