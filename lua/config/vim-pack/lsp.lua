local remote_url = "https://github.com/"

vim.pack.add {
	remote_url .. "williamboman/mason.nvim",
	remote_url .. "williamboman/mason-lspconfig.nvim",
	remote_url .. "WhoIsSethDaniel/mason-tool-installer.nvim",
	remote_url .. "neovim/nvim-lspconfig",
	remote_url .. "hrsh7th/cmp-nvim-lsp",
}

require("mason").setup()

require("mason-tool-installer").setup {
	run_on_start = true,
	start_delay = 3000,
	integrations = { ["mason-lspconfig"] = true },
	ensure_installed = {
		-- LANGUAGE SERVERS
		"nil", -- nix lsp
		"sqlls",
		"pyright",
		"terraform-ls",
		"rust-analyzer",
		"lua-language-server",
		"typescript-language-server",
		"kotlin-language-server",

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
		"alejandra", -- nix formatter
	},
}

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
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities =
				require("cmp_nvim_lsp").default_capabilities(capabilities)
			require("lspconfig")[lsp].setup {
				capabilities = capabilities,
				settings = lsp_settings[lsp] or {},
			}
		end,
	},
}
