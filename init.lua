vim.o.termguicolors = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.autoindent = true
vim.o.number = true


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
  	'nvim-telescope/telescope.nvim', tag = '0.1.5',
 		requires = { 
			{'nvim-lua/plenary.nvim'} 
 		},
		config = function() 
			require('telescope').setup {
				defaults = {
					file_ignore_patterns = { "node_modules", "vendor", "dist", "build" },
				}
			}
		end
	}

	 use { 
	 	'esensar/nvim-dev-container',
	 	as = 'devcontainer',
	 	requires = { 'nvim-treesitter/nvim-treesitter' },
	 	 config = function()
	 	 	require('devcontainer').setup({
	 	 		log_level = "debug",
	 	 		attach_mounts = {
   	 		  neovim_config = {
   	 		    -- enables mounting local config to /root/.config/nvim in container
   	 		    enabled = true,
   	 		    -- makes mount readonly in container
   	 		    options = { "readonly" }
   	 		  },
   	 		  neovim_data = {
   	 		    -- enables mounting local data to /root/.local/share/nvim in container
   	 		    enabled = true,
   	 		    -- no options by default
   	 		    options = {}
   	 		  },
   	 		  -- Only useful if using neovim 0.8.0+
   	 		  neovim_state = {
   	 		    -- enables mounting local state to /root/.local/state/nvim in container
   	 		    enabled = true,
   	 		    -- no options by default
   	 		    options = {}
   	 		  },
   	 		},
	 	 })
	 	 end
	 }


end)


-- map leader to space
vim.g.mapleader = ' '

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
