vim.pack.add {
	{
		src = "https://github.com/" .. "nvim-treesitter/nvim-treesitter",
		version = "main",
	},
}

local ok, treesitter = pcall(require, "nvim-treesitter")
if not ok then return end

treesitter.setup {
	modules = {},
	auto_install = true,
	sync_install = false,
	ignore_install = {},
	ensure_installed = {
		"c",
		"lua",
		"vim",
		"vimdoc",
		"query",
		"regex",
		"yaml",
		"markdown",
		"markdown_inline",
		"kotlin",
		"json",
		"toml",
		"terraform",
		"hcl",
	},
	highlight = {
		enable = true,
		disable = { "terraform", "hcl" },
	},
	indent = { enable = true, disable = { "python", "html" } },
}
