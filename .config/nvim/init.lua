-- Relative Line Numbers
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("state") .. "/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.colorcolumn = "80"

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+y')

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
			vim.keymap.set("n", "<leader>L", vim.cmd.Lines)
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
				italic = {
					strings = false,
					comments = true,
					operators = false,
					folds = true,
				},
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

	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function()
			require 'nvim-treesitter.configs'.setup {
				-- A list of parser names, or "all" (the four listed parsers should always be installed)
				ensure_installed = { "go", "python", "lua", "vim", "help" },

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,

				-- List of parsers to ignore installing (for "all")
				--ignore_install = { "javascript" },

				---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
				-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

				highlight = {
					-- `false` will disable the whole extension
					enable = true,

					-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
					-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
					-- the name of the parser)
					-- list of language that will be disabled
					--disable = { "c", "rust" },
					-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,

					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},
			}
		end
	}

	use {
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
		end
	}

	use {
		"tpope/vim-fugitive",
		config = function()
			-- https://github.com/tpope/vim-fugitive/issues/1237#issuecomment-475005345
			vim.keymap.set("n", "<leader>gs", ":vertical Git<CR>")
			vim.keymap.set("n", "<leader>gl", ":vertical Git log<CR>")
			vim.opt.splitright = true
		end
	}

	use "tpope/vim-commentary"

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
		},
		config = function()
			local lsp = require('lsp-zero')
			lsp.preset('recommended')

			lsp.ensure_installed({
				'bashls',
				'gopls',
				'lua_ls',
			})

			lsp.on_attach(function(client, bufnr)
				local opts = { buffer = bufnr, remap = false }

				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
				vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
				vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

				-- auto format on save, formatting_sync instead of formatting because
				-- formatting is async
				vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ async = false })]]
			end)

			lsp.setup()
		end
	}

	use {
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup {}
		end
	}

	use {
		'nvim-tree/nvim-tree.lua',
		--requires = {
		--	'nvim-tree/nvim-web-devicons', -- optional, for file icons
		--},
		config = function()
			-- says this in the docs:
			-- disable netrw at the very start of your init.lua (strongly advised)
			--vim.g.loaded_netrw = 1
			--vim.g.loaded_netrwPlugin = 1

			require("nvim-tree").setup({
				renderer = {
					icons = {
						show = {
							file = false,
							folder = false,
							folder_arrow = false,
							git = false,
							modified = false,
						},
					},
				},
			})

			vim.keymap.set("n", "<leader>t", vim.cmd.NvimTreeToggle)
		end
	}

	use 'christoomey/vim-tmux-navigator'
end)
