vim.pack.add { "https://github.com/" .. "mfussenegger/nvim-dap" }

local ok, dap = pcall(require, "dap")
if not ok then return end

vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug Continue" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug Step Over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug Step Into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug Step Out" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, {
	desc = "Debug Toggle Breakpoint",
})
