--This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use "nvim-lua/plenary.nvim"
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.4',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim' }}
  }
  ---- not redy yet
  --use({
  -- "rebelot/heirline.nvim",
    -- You can optionally lazy-load heirline on UiEnter
    -- to make sure all required plugins and colorschemes are loaded before setup
    -- event = "UiEnter",
  --config = function()
  --      require("heirline").setup()
  --  end
  --})
  use ({
	  "rebelot/kanagawa.nvim",
	  as="kanagawa",
	  config=function()
		  vim.cmd("colorscheme kanagawa-wave")
	  end
  })
  use {
      'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
  }
  use {
      'nvim-treesitter/nvim-treesitter-context',
  }
  use ({ 'nvim-treesitter/playground'})
  use {
      'nvim-tree/nvim-tree.lua',
      requires = {
          'nvim-tree/nvim-web-devicons', -- optional
      },
  }
  use ({ 'RRethy/vim-illuminate' })
  use ({ 'lervag/vimtex'})
  use ({ 'kylechui/nvim-surround'})
  use {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      requires = { {"nvim-lua/plenary.nvim"} }
  }
  use ({ 'mbbill/undotree'} )
  use ({ 'folke/todo-comments.nvim'} )
  use ({ 'tpope/vim-fugitive' } )
  use ({ 'NiclasEich/FlyAway' })
  use ({ 'github/copilot.vim' })
  use ({ 'CopilotC-NVim/CopilotChat.nvim',
  requires = { 'nvim-lua/plenary.nvim', 'github/copilot.vim' }
    })
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    use {
        "chentoast/marks.nvim",
    }
    use {
        'rmagatti/auto-session',
        config = function()
            require("auto-session").setup {
                suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
            }
        end
    }
end)
