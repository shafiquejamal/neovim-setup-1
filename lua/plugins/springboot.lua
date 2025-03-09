return {
	"nvim-java/nvim-java",
	dependencies = {
		"nvim-java/nvim-java-dap",
		"nvim-java/nvim-java-core",
		"nvim-java/nvim-java-test",
		"nvim-java/nvim-java-refactor",
		"JavaHello/spring-boot.nvim",
	},
	lazy = function()
		-- load this plugin only when your `current directory` is a springboot app
		return #vim.fs.find({
			"settings.gradle",
			"settings.gradle.kts",
			"pom.xml",
			"build.gradle",
			"mvnw",
			"gradlew",
			"build.gradle",
			"build.gradle.kts",
		}, { upward = true, limit = 1 }) == 0
	end,
	config = true,
}
