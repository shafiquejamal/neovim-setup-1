local M = {}

function M.ensure_setup_module()
	local ok, module = pcall(require, "java-refactor")
	if ok and type(module) == "table" and type(module.setup) == "function" then
		return
	end

	-- Work around broken installs that return `true` instead of a setup table.
	package.loaded["java-refactor"] = nil
	package.preload["java-refactor"] = function()
		return {
			setup = function() end,
		}
	end
end

return M
