-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use "wbthomason/packer.nvim"

	use {
		"junegunn/fzf.vim",
		requires = {
			{
				"junegunn/fzf",
				run = ":call fzf#install()"
			}
		},
		config = function()
			vim.keymap.set("n", "<leader>f", vim.cmd.Files)
			vim.keymap.set("n", "<leader>l", vim.cmd.Lines)
			vim.keymap.set("n", "<leader>b", vim.cmd.Buffers)

			-- so that .gitignore is respected
			vim.cmd("let $FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'")
		end
	}

	use {
		'ellisonleao/gruvbox.nvim',
		config = function() -- setup must be called before loading the colorscheme
			-- Default options:
			require("gruvbox").setup({
				undercurl = true,
				underline = true,
				bold = false,
				italic = true,
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "soft", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = true,
				transparent_mode = false,
			})
			vim.cmd("colorscheme gruvbox")
		end
	}

	--use {
	--	'projekt0n/github-nvim-theme',
	--	tag = 'v0.0.7',
	--	config = function()
	--		require("github-theme").setup({
	--			theme_style = "dimmed",
	--		})
	--	end
	--}

	--use {
	--	'rose-pine/neovim',
	--	as = 'rose-pine',
	--	config = function()
	--		require("rose-pine").setup()
	--		vim.cmd('colorscheme rose-pine')
	--	end
	--}

	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}

	use 'mbbill/undotree'

	use {
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gs", ":vertical Git<CR>")
			vim.keymap.set("n", "<leader>gl", ":vertical Git log<CR>")
			vim.opt.splitright = true
		end
	}

	use {
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup()
		end
	}

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v1.x',
		requires = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' }, -- Required
			{ 'williamboman/mason.nvim' }, -- Optional
			{ 'williamboman/mason-lspconfig.nvim' }, -- Optional

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' }, -- Required
			{ 'hrsh7th/cmp-nvim-lsp' }, -- Required
			{ 'hrsh7th/cmp-buffer' }, -- Optional
			{ 'hrsh7th/cmp-path' }, -- Optional
			{ 'saadparwaiz1/cmp_luasnip' }, -- Optional
			{ 'hrsh7th/cmp-nvim-lua' }, -- Optional

			-- Snippets
			{ 'L3MON4D3/LuaSnip' }, -- Required
			{ 'rafamadriz/friendly-snippets' }, -- Optional
		}
	}
end)
