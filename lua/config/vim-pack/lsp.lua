local remote_url = "https://github.com/"
local has_nix = vim.fn.executable "nix" == 1

vim.pack.add {
	remote_url .. "williamboman/mason.nvim",
	remote_url .. "williamboman/mason-lspconfig.nvim",
	remote_url .. "WhoIsSethDaniel/mason-tool-installer.nvim",
	remote_url .. "neovim/nvim-lspconfig",
	remote_url .. "hrsh7th/cmp-nvim-lsp",
}

require("mason").setup()

local lspconfig = require "lspconfig"
local configs = require "lspconfig.configs"
local util = require "lspconfig.util"

local function make_capabilities()
	return require("cmp_nvim_lsp").default_capabilities(
		vim.lsp.protocol.make_client_capabilities()
	)
end

-- Note: terraformls root_markers is overridden in lsp/terraformls.lua to
-- require a .terraform directory, preventing it from starting on uninitialized
-- modules. It is also excluded from mason-lspconfig automatic_enable below
-- as a belt-and-suspenders measure.

require("mason-tool-installer").setup {
	run_on_start = true,
	start_delay = 3000,
	integrations = { ["mason-lspconfig"] = true },
	ensure_installed = {
		-- LANGUAGE SERVERS
		has_nix and "nil" or nil, -- nix lsp
		"sqlls",
		"pyright",
		"terraform-ls",
		"rust-analyzer",
		"lua-language-server",
		"typescript-language-server",
		-- tflint intentionally omitted: it hangs as an LSP server on terraform
		-- modules without `terraform init`. tflint is not used as a CLI linter
		-- here either, since terraform-ls already provides diagnostics.

		-- LINTERS
		"eslint",
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
	-- tflint and terraformls are excluded from automatic_enable:
	-- - tflint hangs as an LSP server on uninitialized terraform modules.
	-- - terraformls is started manually via the FileType autocmd above,
	--   only when a .terraform directory exists.
	automatic_enable = {
		exclude = { "tflint", "terraformls" },
	},
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
