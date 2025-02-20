---@diagnostic disable: undefined-global
return {
	"lewis6991/gitsigns.nvim",
	ft = { "gitcommit", "diff" },
	opts = {
		signs = {
			add = { text = "┃" },
			change = { text = "┃" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signs_staged = {
			add = { text = "┃" },
			change = { text = "┃" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signs_staged_enable = true,
		numhl = true,
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			delay = 100,
		},
		preview_config = {
			border = "rounded",
		},
		attach_to_untracked = true,
		on_attach = function(bufnr)
			local keymap = function(mode, lhs, rhs, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, lhs, rhs, opts)
			end

			-- custom keymaps
			keymap(
				"n",
				"<leader>N",
				"<cmd>Gitsigns prev_hunk<cr>",
				{ desc = "[N] go to previous hunk" }
			)
			keymap(
				"n",
				"<leader>n",
				"<cmd>Gitsigns next_hunk<cr>",
				{ desc = "[n] go to next hunk" }
			)
			keymap(
				"n",
				"<leader>gp",
				"<cmd>Gitsigns preview_hunk<cr>",
				{ desc = "[G]it [P]review Hunk" }
			)
			keymap(
				"n",
				"<leader>gah",
				"<cmd>Gitsigns stage_hunk<cr>",
				{ desc = "[G]it [A]dd [H]unk" }
			)
			keymap(
				"n",
				"<leader>gab",
				"<cmd>Gitsigns stage_buffer<cr>",
				{ desc = "[G]it [A]dd [B]uffer" }
			)
			keymap(
				"n",
				"<leader>gu",
				"<cmd>Gitsigns undo_stage_hunk<cr>",
				{ desc = "[G]it [U]nstage Last Staged" }
			)
			keymap(
				"n",
				"<leader>gr",
				"<cmd>Gitsigns reset_hunk<cr>",
				{ desc = "[G]it [R]eset Current Hunk" }
			)
			keymap(
				"n",
				"<leader>gt",
				"<cmd>Gitsigns toggle_current_line_blame<cr>",
				{ desc = "[G]it [T]oggle line_blame" }
			)
		end,
	},

	config = function(_, opts) require("gitsigns").setup(opts) end,

	init = function()
		vim.api.nvim_create_autocmd({ "BufRead" }, {
			group = vim.api.nvim_create_augroup(
				"GitSignsLazyLoad",
				{ clear = true }
			),
			callback = function()
				vim.fn.system(
					"git -C "
						.. "'"
						.. vim.fn.expand "%:p:h"
						.. "'"
						.. " rev-parse"
				)
				if vim.v.shell_error == 0 then
					vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
					vim.schedule(
						function()
							require("lazy").load { plugins = { "gitsigns.nvim" } }
						end
					)
				end
			end,
		})
	end,
}
