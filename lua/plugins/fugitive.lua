return {
	"tpope/vim-fugitive",
	cmd = { "Git", "Gvdiffsplit" },
	dependencies = { "tpope/vim-rhubarb" },
	keys = {
		{ "<leader>G", "<cmd>Git<cr>", desc = "[G]it fugitive" },
	},
}
