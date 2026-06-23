-- Override the default terraformls config to require a .terraform directory
-- as a root marker. Without this, terraform-ls starts for any terraform file
-- under a git repo, even if `terraform init` has never been run, causing it
-- to hang indefinitely trying to resolve providers.
---@type vim.lsp.Config
return {
	root_markers = { ".terraform" },
}
