return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  event = "VeryLazy",
  config = function()
    local harpoon = require("harpoon")

    -- REQUIRED
    harpoon:setup()
    -- REQUIRED

    -- Your keymaps
    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon add" })
    vim.keymap.set("n", "<C-n>",   function() harpoon:list():next()    end, { desc = "Harpoon next" })
    --vim.keymap.set("n", "<C-h>",     function() harpoon:list():select(1) end, { desc = "Harpoon 1" })
    --vim.keymap.set("n", "<C-t>",     function() harpoon:list():select(2) end, { desc = "Harpoon 2" })
    --vim.keymap.set("n", "<C-n>",     function() harpoon:list():select(3) end, { desc = "Harpoon 3" })
    --vim.keymap.set("n", "<C-s>",     function() harpoon:list():select(4) end, { desc = "Harpoon 4" })
    --vim.keymap.set("n", "<C-S-P>",   function() harpoon:list():prev()    end, { desc = "Harpoon prev" })
    --vim.keymap.set("n", "<C-S-N>",   function() harpoon:list():next()    end, { desc = "Harpoon next" })

    -- Telescope integration with delete support (your second implementation)
    local function toggle_telescope(harpoon_files)
      local finder = function()
        local paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(paths, item.value)
        end
        return require("telescope.finders").new_table({ results = paths })
      end

      local opts = {}
      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = finder(),
        previewer = require("telescope.previewers").vim_buffer_cat.new(opts),
        sorter = require("telescope.config").values.generic_sorter({}),
        layout_config = { height = 0.8, width = 0.9, prompt_position = "bottom", preview_cutoff = 40 },
        attach_mappings = function(prompt_bufnr, map)
          map("i", "<C-d>", function()
            local state = require("telescope.actions.state")
            local sel = state.get_selected_entry()
            local picker = state.get_current_picker(prompt_bufnr)
            table.remove(harpoon_files.items, sel.index)
            picker:refresh(finder())
          end)
          return true
        end,
      }):find()
    end

    -- Your <C-e> opens Harpoon in Telescope
    vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
      { desc = "Open Harpoon (Telescope)" })
  end,
}

