local M = {}

local set = vim.cmd
local config = require "dark_flat.config"
local themes = require "dark_flat.themes"

function M.setup(user_config)
    if vim.g.colors_name then
        set.hi "clear"
    end

    if vim.fn.exists "syntax_on" then
        set.syntax "reset"
    end

    vim.o.background = "dark"
    vim.o.termguicolors = true
    vim.g.colors_name = "dark_flat"

    -- load user config and themes
    config:extend(user_config)
    themes.load()

    if user_config then
        set.colorscheme "dark_flat"
    end
end

return M
