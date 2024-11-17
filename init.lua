vim.o.termguicolors = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.autoindent = true
vim.o.number = true
vim.g.mapleader = ' '

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
	use {'neoclide/coc.nvim', branch = 'release'}
	
	use 'scrooloose/nerdtree'
	use 'Xuyuanp/nerdtree-git-plugin'

	use 'tpope/vim-fugitive'
	use 'airblade/vim-gitgutter'
	use 'vim-airline/vim-airline'
	use 'vim-airline/vim-airline-themes'
	
	use 'neovim/nvim-lspconfig'
	use 'nvim-lua/plenary.nvim'
	use 'antoinemadec/FixCursorHold.nvim'
	use 'nvim-neotest/neotest'
	use 'nvim-treesitter/nvim-treesitter'
	
	use {
  	'nvim-telescope/telescope.nvim', tag = '0.1.8',
 		requires = { 
			{'nvim-lua/plenary.nvim'} 
 		},
		config = function() 
			require('telescope').setup {
								defaults = {
					file_ignore_patterns = { "node_modules", "vendor", "dist", "build", "target" },
				 },
				pickers = {
    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
      theme = "dropdown",
      previewer = false,
      mappings = {
        i = {
          ["<c-d>"] = "delete_buffer",
        },
				n = {
          ["d"] = "delete_buffer",
        }
      }
    }
  },
			}
		end
	}

	use "hrsh7th/nvim-cmp"

use({
-- cmp LSP completion
"hrsh7th/cmp-nvim-lsp",
-- cmp Snippet completion
"hrsh7th/cmp-vsnip",
-- cmp Path completion
"hrsh7th/cmp-path",
"hrsh7th/cmp-buffer",
after = { "hrsh7th/nvim-cmp" },
requires = { "hrsh7th/nvim-cmp" },
})

use("simrat39/rust-tools.nvim")
end)

require("rust")

-- map ctrl + s to save
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })

-- map enter to accept completion coc
vim.api.nvim_set_keymap('i', '<CR>', 'pumvisible() ? coc#_select_confirm() : "<CR>"', { noremap = true, silent = true, expr = true })

-- map nerdtree toggle
vim.api.nvim_set_keymap('n', '<C-b>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })

-- map control + p to telescope
vim.api.nvim_set_keymap('n', '<C-p>', ':Telescope find_files<CR>', { noremap = true, silent = true })

-- map control + f to telescope live grep
vim.api.nvim_set_keymap('n', '<C-f>', ':Telescope live_grep<CR>', { noremap = true, silent = true })

-- Use ctrl-[hjkl] to select the active split!
vim.api.nvim_set_keymap('n', '<c-k>', ':wincmd k<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<c-j>', ':wincmd j<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<c-h>', ':wincmd h<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<c-l>', ':wincmd l<CR>', { noremap = true, silent = true })
