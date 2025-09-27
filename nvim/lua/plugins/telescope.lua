return {
  "nvim-telescope/telescope.nvim",
  version = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },

  main = "telescope",
  opts = {
    pickers = { find_files = { -- theme = "dropdown",
    } },
  },

  keys = {
    { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
    { "<leader>fg", function() require("telescope.builtin").live_grep()  end, desc = "Live grep" },
    { "<leader>fb", function() require("telescope.builtin").buffers()    end, desc = "Buffers" },
    { "<leader>fh", function() require("telescope.builtin").help_tags()  end, desc = "Help tags" },
    { "<leader>fm", function() require("telescope.builtin").marks()      end, desc = "Marks" },
    { "<leader>fc", function() require("telescope.builtin").colorscheme() end, desc = "Colorscheme" },
    { "<C-p>",      function() require("telescope.builtin").git_files()  end, desc = "Git files" },

    { "<leader>ps", function()
        require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
      end, desc = "Grep prompt" },

    { "<leader>/", function()
        local word = vim.fn.expand("<cword>")
        require("telescope.builtin").current_buffer_fuzzy_find{
          default_text  = word,
          case_mode     = "ignore_case",
          previewer     = false,
          layout_config = { width = 0.5 },
        }
      end, desc = "Buffer search (word under cursor)" },

    { "<leader>s", function()
        require("telescope.builtin").current_buffer_fuzzy_find{
          case_mode     = "ignore_case",
          previewer     = false,
          layout_config = { width = 0.5 },
        }
      end, desc = "Buffer search (ignore case)" },
  },

  cmd = "Telescope",
}

