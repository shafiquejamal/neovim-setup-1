vim.pack.add { "https://github.com/" .. "folke/snacks.nvim" }

local ok, snacks = pcall(require, "snacks")
if not ok then return end

snacks.setup {
	indent = {
		-- Disabled for terraform/hcl: scanning long lines for indent guides
		-- causes a str_utfindex freeze on larger files.
		enabled = false,
	},
	lazygit = {},
	quickfile = {},
}

vim.keymap.set(
	"n",
	"<leader>lg",
	"<cmd>lua Snacks.lazygit()<cr>",
	{ desc = "[L]azy [G]it" }
)
