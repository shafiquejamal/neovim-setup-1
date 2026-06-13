-- Kotlin / Gradle integration
-- Keymaps are set up globally; the terminal commands are harmless outside Gradle projects.
-- Use <leader>gd* for Gradle tasks (mnemonic: Gra[d]le).

local keymap = function(lhs, rhs, desc)
	vim.keymap.set("n", lhs, rhs, { desc = desc })
end

-- Run Gradle wrapper commands in a new terminal split at the project root.
-- Falls back to cwd if no gradlew is found upward.
local function gradlew_cmd(task)
	return function()
		local root = vim.fs.root(0, { "gradlew", "settings.gradle", "settings.gradle.kts" })
		local cmd = (root and (root .. "/gradlew") or "./gradlew") .. " " .. task
		vim.cmd("botright 15split | term " .. cmd)
	end
end

keymap("<leader>gdb", gradlew_cmd("build"), "[G]ra[d]le [b]uild")
keymap("<leader>gdt", gradlew_cmd("test"), "[G]ra[d]le [t]est")
keymap("<leader>gdc", gradlew_cmd("clean"), "[G]ra[d]le [c]lean")
keymap("<leader>gdr", gradlew_cmd("run"), "[G]ra[d]le [r]un")
keymap("<leader>gdR", gradlew_cmd("runClient"), "[G]ra[d]le [R]un client")
keymap("<leader>gdC", gradlew_cmd("clean build"), "[G]ra[d]le [C]lean build")
