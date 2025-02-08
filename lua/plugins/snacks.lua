return {
	"folke/snacks.nvim",
	enabled = true,
	event = { "BufReadPost", "BufNewfile" },
	keys = {
		{
			"<leader>lg",
			"<cmd>lua Snacks.lazygit()<cr>",
			desc = "[L]azy [G]it",
		},
	},
	opts = {
		indent = {},
		lazygit = {},
		quickfile = {},
	},
}
