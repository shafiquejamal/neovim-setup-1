local remote_url = "https://github.com/"

vim.pack.add {
	remote_url .. "williamboman/mason.nvim",
	remote_url .. "williamboman/mason-lspconfig.nvim",
	remote_url .. "WhoIsSethDaniel/mason-tool-installer.nvim",
	remote_url .. "neovim/nvim-lspconfig",
	remote_url .. "hrsh7th/cmp-nvim-lsp",
}

require("mason").setup()

local lspconfig = require("lspconfig")

local function make_capabilities()
	return require("cmp_nvim_lsp").default_capabilities(
		vim.lsp.protocol.make_client_capabilities()
	)
end

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
	lspconfig.kotlin_lsp.setup {
		capabilities = make_capabilities(),
		cmd = { kotlin_lsp, "--stdio" },
	}
end
