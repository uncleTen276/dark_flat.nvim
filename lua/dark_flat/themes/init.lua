local themes = {}

local config = require "dark_flat.config"
local highlight = require "dark_flat.themes.highlight"
local logs = require "dark_flat.logs"

function themes.load()
    local colors = require "dark_flat.colors"
    local groups = require "dark_flat.themes.groups"

    local default = highlight:new(groups)
    local user_themes = config.themes(colors)

    -- set default if user has no custom themes
    if vim.tbl_isempty(user_themes) then
        default:set()

        return
    end

    -- extend default with user config
    local extended = default:extend(user_themes)
    local set_theme_ok, err = pcall(function()
        extended:set()
    end)

    if not set_theme_ok then
        default:set()

        logs.error.notify(err)
    end
end

return themes
