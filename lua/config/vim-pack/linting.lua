vim.pack.add { "https://github.com/" .. "mfussenegger/nvim-lint" }

local ok, lint = pcall(require, "lint")
if not ok then return end

lint.linters_by_ft = {
	lua = { "luacheck" },
	sh = { "shellcheck" },
	yaml = { "yamllint" },
	python = { "pylint" },
	java = { "checkstyle" },
	-- tflint removed: it hangs as both an LSP server and CLI linter on terraform
	-- modules without `terraform init`. Diagnostics are provided by terraform-ls.
	javascript = { "eslint" },
	typescript = { "eslint" },
	javascriptreact = { "eslint" },
	typescriptreact = { "eslint" },
}

vim.api.nvim_create_autocmd(
	{ "BufReadPost", "BufNewFile", "ModeChanged", "BufWritePost" },
	{
		group = vim.api.nvim_create_augroup("PerformLinting", { clear = true }),
		callback = function()
			require("lint").try_lint(nil, { ignore_errors = true })
		end,
	}
)
