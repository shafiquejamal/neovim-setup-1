-- TODO: properly configure LSP config
return {
	"neovim/nvim-lspconfig",
	enabled = false,
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "williamboman/mason.nvim", config = true },
	},
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	config = true,
	-- [[
	--
	-- language_servers:
	--      - lua_ls
	--      - pyright
	--      - rust_analyzer
	--      - sqlls
	--      - ts_ls
	--      - eslint
	--      - terraformls
	--
	-- formatters:
	--      - stylua
	--
	-- linters:
	--      - tflint
	-- ]]
}
