-- Kotlin / Gradle integration (lazy.nvim path)
-- No new plugin dependency — just keymaps around ./gradlew.
-- Use <leader>gd* for Gradle tasks (mnemonic: Gra[d]le).

local function gradlew_cmd(task)
	return function()
		local root = vim.fs.root(
			0,
			{ "gradlew", "settings.gradle", "settings.gradle.kts" }
		)
		local cmd = (root and (root .. "/gradlew") or "./gradlew")
			.. " "
			.. task
		vim.cmd("botright 15split | term " .. cmd)
	end
end

return {
	{
		-- Dummy plugin spec: no plugin to install, just keymaps registered on startup.
		-- vim-which-key will pick up the `desc` strings automatically.
		"nvim-lua/plenary.nvim",
		lazy = true, -- already a dep elsewhere; this spec only adds keys
		keys = {
			{
				"<leader>gdb",
				gradlew_cmd "build",
				desc = "[G]ra[d]le [b]uild",
			},
			{ "<leader>gdt", gradlew_cmd "test", desc = "[G]ra[d]le [t]est" },
			{
				"<leader>gdc",
				gradlew_cmd "clean",
				desc = "[G]ra[d]le [c]lean",
			},
			{ "<leader>gdr", gradlew_cmd "run", desc = "[G]ra[d]le [r]un" },
			{
				"<leader>gdR",
				gradlew_cmd "runClient",
				desc = "[G]ra[d]le [R]un client",
			},
			{
				"<leader>gdC",
				gradlew_cmd "clean build",
				desc = "[G]ra[d]le [C]lean build",
			},
		},
	},
}
