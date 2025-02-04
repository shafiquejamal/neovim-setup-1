-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("i", "jj", "<Esc>")
-- -- https://www.reddit.com/r/neovim/comments/16cso6u/how_to_keymap_cmd_s_in_lazy_nvim_to_save_file/?rdt=44443
vim.keymap.set(
	{ "n", "i" },
	"ww",
	"<cmd>update<cr><esc>",
	{ desc = "Save file" }
)
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Diagnostic keymaps
vim.keymap.set(
	"n",
	"<leader>q",
	vim.diagnostic.setloclist,
	{ desc = "Open diagnostic [Q]uickfix list" }
)
vim.diagnostic.config {
	update_in_insert = true,
	float = {
		max_width = 80,
		max_height = 20,
		wrap = true,
		border = "rounded",
	},
	virtual_text = {
		prefix = "●",
		spacing = 4,
		source = "always",
		wrap = true,
	},
}
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set(
	"t",
	"<Esc><Esc>",
	"<C-\\><C-n>",
	{ desc = "Exit terminal mode" }
)

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- C-w + v/h for vertical/horizontal split
--[[ vim.keymap.set(
	"n",
	"<C-h>",
	"<C-w><C-h>",
	{ desc = "Move focus to the left window" }
)
vim.keymap.set(
	"n",
	"<C-l>",
	"<C-w><C-l>",
	{ desc = "Move focus to the right window" }
)
vim.keymap.set(
	"n",
	"<C-j>",
	"<C-w><C-j>",
	{ desc = "Move focus to the lower window" }
)
vim.keymap.set(
	"n",
	"<C-k>",
	"<C-w><C-k>",
	{ desc = "Move focus to the upper window" }
)
]]
vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})

-- delete without copying into register
vim.keymap.set({ "n", "v" }, "X", "\"_X")
vim.keymap.set({ "n", "v" }, "x", "\"_x")
vim.keymap.set({ "n", "v" }, "D", "\"_D")
vim.keymap.set({ "n", "v" }, "d", "\"_d")

-- https://www.reddit.com/r/neovim/comments/v7s1ts/how_do_i_avoid_replacing_the_content_of_my/
vim.keymap.set(
	"x",
	"p",
	function() return "pgv\"" .. vim.v.register .. "y" end,
	{ remap = false, expr = true }
)
