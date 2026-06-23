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
			local has_nix = vim.fn.executable "nix" == 1
			require("mason-tool-installer").setup {
				ensure_installed = {
					-- LANGUAGE SERVERS
					"sqlls",
					"pyright",
					"terraform-ls",
					"rust-analyzer",
					"lua-language-server",
					"typescript-language-server",
					has_nix and "nil" or nil, -- nix lsp

					-- LINTERS
					"eslint",
					"tflint",
					"shellcheck",
					"checkstyle",

					-- FORMATTERS
					"shfmt",
					"stylua",
					"prettier",
					"gofumpt",
					"goimports",
					"rustfmt",
					"google-java-format",
					"ktfmt",
					has_nix and "alejandra" or nil, -- nix formatter
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
			local lspconfig = require "lspconfig"
			local configs = require "lspconfig.configs"
			local util = require "lspconfig.util"

			local function make_capabilities()
				return require("cmp_nvim_lsp").default_capabilities(
					vim.lsp.protocol.make_client_capabilities()
				)
			end

			local lsp_settings = {
				rust_analyzer = {
					["rust-analyzer"] = {
						imports = {
							granularity = { group = "module" },
							prefix = "self",
						},
						completion = { autoimport = true },
					},
				},
			}
			require("mason-lspconfig").setup {
				handlers = {
					function(lsp)
						lspconfig[lsp].setup {
							capabilities = make_capabilities(),
							settings = lsp_settings[lsp] or {},
						}
					end,
				},
			}

			-- Official Kotlin LSP is installed outside Mason.
			local kotlin_lsp = vim.fn.exepath "kotlin-lsp"
			if kotlin_lsp ~= "" then
				if not configs.kotlin_lsp then
					configs.kotlin_lsp = {
						default_config = {
							cmd = { kotlin_lsp, "--stdio" },
							filetypes = { "kotlin" },
							root_dir = util.root_pattern(
								"settings.gradle",
								"settings.gradle.kts",
								"pom.xml",
								"build.gradle",
								"build.gradle.kts",
								"workspace.json"
							),
						},
					}
				end

				lspconfig.kotlin_lsp.setup {
					capabilities = make_capabilities(),
					cmd = { kotlin_lsp, "--stdio" },
				}
			end
		end,
	},
}
