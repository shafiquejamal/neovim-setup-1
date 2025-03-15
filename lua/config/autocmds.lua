-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup(
		"shafiquejamal/highlight-yank",
		{ clear = true }
	),
	callback = function() vim.highlight.on_yank() end,
})

-- Setup Lsp Keymaps and highlight Lsp References on LspAttach event
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup(
		"shafiquejamal/LspAttach",
		{ clear = true }
	),
	callback = function(event)
		local keymap = function(keys, func, desc)
			if desc then desc = "LSP: " .. desc end
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
		end
		keymap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		keymap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
		keymap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
		keymap("<leader>lr", vim.lsp.buf.references, "[L]sp [R]eferences")
		keymap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
		keymap("gt", vim.lsp.buf.type_definition, "[G]oto [T]ype Definition")
		keymap("K", vim.lsp.buf.hover, "Hover Documentation")
		keymap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

		-- highlight LSP References
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.server_capabilities.documentHighlightProvider then
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				callback = vim.lsp.buf.clear_references,
			})
		end
	end,
})

-- Lsp cleanups on LspDetach event
vim.api.nvim_create_autocmd("LspDetach", {
	group = vim.api.nvim_create_augroup(
		"shafiquejamal/LspDetach",
		{ clear = true }
	),
	callback = function(event)
		vim.lsp.buf.clear_references()
		vim.api.nvim_clear_autocmds {
			group = "shafiquejamal/LspDetach",
			buffer = event.buf,
		}
	end,
})
