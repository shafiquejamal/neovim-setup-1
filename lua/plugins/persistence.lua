return {
	"folke/persistence.nvim",
	enabled = true, -- Set this to `false` if u want to disable this plugin.
	init = function()
		local nvim_sessions = vim.fn.stdpath "state" .. "/sessions/"
		local tmux_sessions = vim.fn.expand "~/.local/share/tmux/resurrect/"

		local tmux_sessions_exists = vim.fn.empty(
			vim.fn.globpath(tmux_sessions, "*")
		) == 0

		local nvim_sessions_exists = vim.fn.empty(
			vim.fn.globpath(nvim_sessions, "*")
		) == 0

		local is_inside_tmux = vim.env.TMUX ~= nil

		if nvim_sessions_exists and tmux_sessions_exists and is_inside_tmux then
			-- Restore neovim sessions
			vim.schedule(function() require("persistence").load() end)
		end
	end,
	opts = {},
}
