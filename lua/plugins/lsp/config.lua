return {
	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			-- Allows extra capabilities provided by nvim-cmp
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend(
				"force",
				capabilities,
				require("cmp_nvim_lsp").default_capabilities()
			)

			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
			local servers = {
				-- clangd = {},
				-- gopls = {},
				pyright = {},
				rust_analyzer = {
					cmd = { "rustup", "run", "stable", "rust-analyzer" },
					settings = {
						["rust-analyzer"] = {
							editor = { formatOnSave = true },
							check = { command = "clippy" },
						},
					},
				},
				sqlls = {
					cmd = { "sql-language-server", "up", "--method", "stdio" },
					filetypes = { "sql", "pgsql" },
					settings = {},
				},
				-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
				--
				-- Some languages (like typescript) have entire language plugins that can be useful:
				--    https://github.com/pmizio/typescript-tools.nvim
				--
				-- But for many setups, the LSP (`ts_ls`) will work just fine
				ts_ls = {},
				eslint = {
					on_attach = function(client, bufnr)
						-- Enable formatting
						client.server_capabilities.documentFormattingProvider =
							true

						-- Autofix on save
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = bufnr,
							command = "EslintFixAll",
						})
					end,
					settings = {
						-- Format options
						format = true,
						-- Working directory mode
						workingDirectory = { mode = "location" },
						-- Run eslint when you save the file
						run = "onSave",
						-- Code action settings
						codeAction = {
							disableRuleComment = {
								enable = true,
								location = "separateLine",
							},
							showDocumentation = {
								enable = true,
							},
						},
						-- Enable autofix on save
						codeActionOnSave = {
							enable = true,
							mode = "all",
						},
					},
				},
				lua_ls = {
					-- cmd = {...},
					-- filetypes = { ...},
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
				terraformls = {
					filetypes = { "terraform", "tf", "terraform-vars" },
					settings = {
						terraform = {
							-- Enable format on save
							format = {
								enable = true,
								formatOnSave = true,
							},
							-- Enable terraform validate on save
							validateOnSave = true,
						},
					},
				},
			}

			-- Ensure the servers and tools above are installed
			--  To check the current status of installed tools and/or manually install
			--  other tools, you can run
			--    :Mason
			--
			--  You can press `g?` for help in this menu.
			require("mason").setup()

			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
				"pyright",
				"terraform-ls", -- Terraform LSP
				"tflint", -- Terraform linter
			})
			require("mason-tool-installer").setup {
				ensure_installed = ensure_installed,
			}

			require("mason-lspconfig").setup {
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for ts_ls)
						server.capabilities = vim.tbl_deep_extend(
							"force",
							{},
							capabilities,
							server.capabilities or {}
						)
						require("lspconfig")[server_name].setup(server)
					end,
				},
			}
		end,
	},
}

