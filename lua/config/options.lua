local opt = vim.opt

-- disable swapfiles
vim.o.swapfile = false

-- UI

-- Make line numbers default
opt.number = true

-- You can also add relative line numbers, to help with jumping.
-- Experiment for yourself to see if you like it!
opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Show which line your cursor is on
opt.cursorline = true

-- Keep signcolumn on by default
opt.signcolumn = "yes"

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

-- Editing

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = false
opt.smartcase = true

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
opt.timeoutlen = 300

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
opt.list = true
-- opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.listchars:append "tab:│ "
opt.listchars:append "trail:␣"

-- Preview substitutions live, as you type!
opt.inccommand = "split"

-- Windows

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Clipboard

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function() opt.clipboard = "unnamedplus" end)
