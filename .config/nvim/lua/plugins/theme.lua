return {
	{
		'ellisonleao/gruvbox.nvim',
		config = function() -- setup must be called before loading the colorscheme
			-- Default options:
			require("gruvbox").setup({
				undercurl = true,
				underline = true,
				bold = false,
				italic = {
					strings = false,
					comments = false,
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
	},

	-- use {
	-- 	"mcchrish/zenbones.nvim",
	-- 	requires = "rktjmp/lush.nvim",
	-- 	config = function()
	-- 		-- vim.g.zenbones_darkness = 'stark'
	-- 		vim.cmd("colorscheme zenbones")
	-- 	end
	-- },
}
