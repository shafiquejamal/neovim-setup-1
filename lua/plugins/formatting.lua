return { -- Autoformat
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {

		{
			"<leader>f",
			function()
				require("conform").format {
					async = true,
					lsp_format = "never",
				}
			end,
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = true,
		format_on_save = { timeout_ms = 500, lsp_format = "never" },
		formatters = {
			["prettier"] = {
				prepend_args = {
					"--ignore-unknown",
					"--config-precedence",
					"prefer-file",
				},
			},
		},
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "goimports", "gofmt" },
			rust = { "rustfmt", lsp_format = "fallback" },
			javascript = { "prettierd", "prettier", "eslint_d" },
			typescript = { "prettierd", "prettier", "eslint_d" },
			javascriptreact = { "prettierd", "prettier", "eslint_d" },
			typescriptreact = { "prettierd", "prettier", "eslint_d" },
			svelte = { "prettierd", "prettier" },
			css = { "prettierd", "prettier" },
			html = { "prettierd", "prettier" },
			json = { "prettierd", "prettier" },
			yaml = { "prettierd", "prettier" },
			terraform = { "terraform_fmt" },
			hcl = { "terragrunt_hclfmt", "packer_fmt" },
			markdown = { "prettierd", "prettier" },
			graphql = { "prettierd", "prettier" },
			java = { "google_java_format" },
			kotlin = { "ktfmt" },
			nix = { "alejandra" },
		},
		stop_after_first = true, -- Ensures only the first formatter is used
	},
}
