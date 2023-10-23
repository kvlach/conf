return {
	{
		"junegunn/fzf.vim",
		dependencies = {
			{
				"junegunn/fzf",
				build = ":call fzf#install()"
			}
		},
		config = function()
			vim.keymap.set("n", "<leader>f", vim.cmd.Files)
			vim.keymap.set("n", "<leader>L", vim.cmd.Lines)
			vim.keymap.set("n", "<leader>b", vim.cmd.Buffers)

			-- so that .gitignore is respected
			vim.cmd("let $FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'")
		end
	},

	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
		end
	},

	{
		"tpope/vim-commentary"
	},

	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup {}
		end
	},

	{
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
	},

	{
		'christoomey/vim-tmux-navigator'
	},
}
