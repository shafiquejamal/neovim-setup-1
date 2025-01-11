-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require("lazy").setup({
    { import = "plugins.telescope" },
    { import = "plugins.lsp" },
    { import = "plugins.format" },
    { import = "plugins.completion" },
    { import = "plugins.treesitter" },
    { import = "plugins.editor" },

    -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
	-- init.lua. If you want these files, they are in the repository, so you can just download them and
	-- place them in the correct locations.

	-- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
	--
	--  Here are some example plugins that I've included in the Kickstart repository.
	--  Uncomment any of the lines below to enable them (you will need to restart nvim).
	--
	-- require 'kickstart.plugins.debug',
	-- require 'kickstart.plugins.indent_line',
	-- require 'kickstart.plugins.lint',
	-- require 'kickstart.plugins.autopairs',
	-- require 'kickstart.plugins.neo-tree',
	-- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

	-- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
	--    This is the easiest way to modularize your config.
	--
	--  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
	--    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
	-- { import = 'custom.plugins' },
}, {
    ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
        icons = vim.g.have_nerd_font and {} or {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            require = "🌙",
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤 ",
        },
    },
})

-- -- The line beneath this is called `modeline`. See `:help modeline`
-- -- vim: ts=2 sts=2 sw=2 et

-- -- call plug#begin()

-- -- Plug 'ThePrimeagen/vim-be-good'

-- -- call plug#end()

-- local vim = vim
-- local Plug = vim.fn["plug#"]

-- vim.call("plug#begin")

-- -- Shorthand notation for GitHub; translates to https://github.com/junegunn/seoul256.vim.git
-- Plug("junegunn/seoul256.vim")

-- -- Any valid git URL is allowed
-- Plug("https://github.com/junegunn/vim-easy-align.git")

-- -- Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
-- Plug("fatih/vim-go", { ["tag"] = "*" })

-- -- Using a non-default branch
-- Plug("neoclide/coc.nvim", { ["branch"] = "release" })

-- -- Use 'dir' option to install plugin in a non-default directory
-- Plug("junegunn/fzf", { ["dir"] = "~/.fzf" })

-- -- Post-update hook: run a shell command after installing or updating the plugin
-- Plug("junegunn/fzf", { ["dir"] = "~/.fzf", ["do"] = "./install --all" })

-- -- Post-update hook can be a lambda expression
-- Plug("junegunn/fzf", {
-- 	["do"] = function()
-- 		vim.fn["fzf#install"]()
-- 	end,
-- })

-- -- If the vim plugin is in a subdirectory, use 'rtp' option to specify its path
-- Plug("nsf/gocode", { ["rtp"] = "vim" })

-- -- On-demand loading: loaded when the specified command is executed
-- Plug("preservim/nerdtree", { ["on"] = "NERDTreeToggle" })

-- -- On-demand loading: loaded when a file with a specific file type is opened
-- Plug("tpope/vim-fireplace", { ["for"] = "clojure" })

-- -- Unmanaged plugin (manually installed and updated)
-- Plug("~/my-prototype-plugin")

-- Plug("ThePrimeagen/vim-be-good")
-- Plug("navarasu/onedark.nvim")

-- vim.call("plug#end")

-- -- Lua
-- require("onedark").load()
-- vim.cmd([[colorscheme onedark]])
-- require("nvim-autopairs").setup({})
