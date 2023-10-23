return {
	{
		"tpope/vim-fugitive",
		config = function()
			-- https://github.com/tpope/vim-fugitive/issues/1237#issuecomment-475005345
			vim.keymap.set("n", "<leader>gs", ":vertical Git<CR>")
			vim.keymap.set("n", "<leader>gl", ":vertical Git log<CR>")
			vim.opt.splitright = true
		end
	},

	{
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup()
		end
	},
}
