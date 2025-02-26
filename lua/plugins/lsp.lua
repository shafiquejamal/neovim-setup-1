-- TODO: properly configure LSP config
return {
	{
		-- Installer for lsp,linter,formatter
		-- Use :Mason for manual installation of lsp, liter, and formatter
		"williamboman/mason.nvim",
		cmd = {
			"Mason",
			"MasonLog",
			"MasonUpdate",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
		},
	},
	{
		-- Automatic installer for linters, formatters, and lsp's
		-- The installation of tools in here run only once  (when running `nvim` for the first time)
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim", config = true },
		build = ":MasonToolsUpdate",
		cmd = { "MasonToolsInstall", "MasonToolsUpdate", "MasonToolsClean" },
		config = function()
			require("mason-tool-installer").setup {
				ensure_installed = {
					-- LANGUAGE SERVERS
					"sqlls",
					"pyright",
					"terraform-ls",
					"rust-analyzer",
					"lua-language-server",
					"typescript-language-server",

					-- LINTERS
					"eslint",
					"tflint",
					"shellcheck",

					-- FORMATTERS
					"shfmt",
					"stylua",
					"prettier",
					"gofumpt",
					"goimports",
					"rustfmt",
				},
			}
		end,
	},
	{
		-- Neovim Lsp Client
		"neovim/nvim-lspconfig",
		enabled = true,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason-lspconfig.nvim",
		},
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities =
				require("cmp_nvim_lsp").default_capabilities(capabilities)

			require("mason-lspconfig").setup_handlers {
				function(lsp)
					require("lspconfig")[lsp].setup {
						capabilities = capabilities,
					}
				end,
			}
		end,
	},
}
