-- Default options:
require('kanagawa').setup({
    compile = false,             -- enable compiling the colorscheme
    undercurl = true,            -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true},
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false,         -- do not set background color
    dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
    terminalColors = true,       -- define vim.g.terminal_color_{0,17}
    colors = {                   -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
    },
    overrides = function(colors) -- add/modify highlights
        return {}
    end,
    theme = "dragon",              -- Load "wave" theme when 'background' option is not set
    background = {               -- map the value of 'background' option to a theme
        dark = "wave",           -- try "dragon" !
        light = "lotus"
    },
})

-- setup must be called before loading
vim.cmd.colorscheme('tokyonight-storm')
--
-- Function to cycle through colorschemes
local colorschemes = { 'kanagawa-wave', 'tokyonight-storm',}
local current_index = 1

function CycleColorscheme()
    current_index = current_index % #colorschemes + 1
    vim.cmd.colorscheme(colorschemes[current_index])
    print("Colorscheme changed to " .. colorschemes[current_index])
end

-- Map the function to a keybinding, for example <leader>cs
vim.api.nvim_set_keymap('n', '<leader>cs', ':lua CycleColorscheme()<CR>', { noremap = true, silent = true })
