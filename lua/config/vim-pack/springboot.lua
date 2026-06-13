local function is_java_project()
	return #vim.fs.find({
		"settings.gradle",
		"settings.gradle.kts",
		"pom.xml",
		"build.gradle",
		"mvnw",
		"gradlew",
		"build.gradle.kts",
	}, { upward = true, limit = 1 }) > 0
end

if is_java_project() then
	require("custom.java.refactor_compat").ensure_setup_module()

	local remote_url = "https://github.com/"
	vim.pack.add {
		{ src = remote_url .. "nvim-java/nvim-java" },
		{ src = remote_url .. "nvim-java/nvim-java-dap" },
		{ src = remote_url .. "nvim-java/nvim-java-core" },
		{ src = remote_url .. "nvim-java/nvim-java-test" },
		{ src = remote_url .. "nvim-java/nvim-java-refactor" },
		{ src = remote_url .. "JavaHello/spring-boot.nvim" },
	}

	require("java").setup {
		-- Startup checks
		checks = {
			nvim_version = true, -- Check Neovim version
			nvim_jdtls_conflict = true, -- Check for nvim-jdtls conflict
		},

		-- JDTLS configuration
		jdtls = {
			version = "1.43.0",
		},

		-- Extensions
		lombok = {
			enable = true,
			version = "1.18.40",
		},

		java_test = {
			enable = true,
			version = "0.40.1",
		},

		java_debug_adapter = {
			enable = true,
			version = "0.58.2",
		},

		spring_boot_tools = {
			enable = true,
			version = "1.55.1",
		},

		-- JDK installation
		jdk = {
			auto_install = false,
			version = "17",
		},

		-- Logging
		log = {
			use_console = true,
			use_file = true,
			level = "info",
			log_file = vim.fn.stdpath "state" .. "/nvim-java.log",
			max_lines = 1000,
			show_location = false,
		},
	}
end
