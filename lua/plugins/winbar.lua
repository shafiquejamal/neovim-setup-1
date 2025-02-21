return {
	"utilyre/barbecue.nvim",
	name = "barbecue",
	version = "*",
	lazy = vim.fn.argc(-1) == 0,
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	opts = { attach_navic = false, show_navic = false },
	dependencies = { "SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons" },
}
