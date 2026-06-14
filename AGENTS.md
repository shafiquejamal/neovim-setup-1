# AGENTS.md

## Purpose

This repository contains a personal Neovim configuration rooted at `init.lua`.

## Entry Points

- `init.lua` sets the leaders and loads `require("config")`.
- `lua/config/init.lua` loads core editor config first:
  - `lua/config/options.lua`
  - `lua/config/keymaps.lua`
  - `lua/config/autocmds.lua`
  - `lua/config/diagnostic.lua`
- Plugin loading then splits by Neovim version:
  - Neovim `< 0.12`: `lua/config/lazy.lua` bootstraps `lazy.nvim` and loads plugin specs from `lua/plugins/*.lua`
  - Neovim `>= 0.12`: `lua/config/vim-pack/init.lua` loads the newer `vim-pack` config files from `lua/config/vim-pack/*.lua`

## Repository Shape

- `lua/config/*.lua`: shared editor configuration
- `lua/plugins/*.lua`: `lazy.nvim` plugin specs and config blocks
- `lua/config/vim-pack/*.lua`: version-gated plugin config for the Neovim 0.12 path
- `lua/custom/**`: small custom helpers used by plugin config
- `after/ftplugin/*.lua`: filetype-specific settings
- `lazy-lock.json`: lazy.nvim lockfile
- `nvim-pack-lock.json`: vim-pack lockfile

## Working Conventions

- Keep changes small and local.
- If you change plugin behavior, update the active codepath for the Neovim version in use instead of editing unrelated duplicate files.
- When a plugin exists in both `lua/plugins/` and `lua/config/vim-pack/`, check whether the same behavior must be updated in both places.
- Match the existing Lua style in the touched file; this repo uses tabs in many Lua files.
- Follow `stylua.toml` when editing Lua. In particular, `call_parentheses = "None"`, so simple calls like `require` should use `require "module"` instead of `require("module")`.
- Prefer direct Neovim APIs and existing patterns over adding new abstraction layers.

## Validation

- After changing any Lua file, run a local Stylua check before finishing or pushing:
  - `nix shell nixpkgs#stylua -c stylua --check init.lua lua`
- For Lua syntax or startup regressions, use headless Neovim against this config, for example:
  - `nvim --headless '+qa'`
- If you changed plugin bootstrap or plugin declarations, also verify the relevant manager path loads cleanly in the Neovim version being targeted.

## Notes

- `README.md` still mentions `vim-plug`, but the current codebase uses `lazy.nvim` for older Neovim and `vim-pack` for Neovim 0.12+.
