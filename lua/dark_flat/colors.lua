local colors = {}

local config = require "dark_flat.config"
local logs = require "dark_flat.logs"

---@class palette
colors.default = {
    fg = "#b0bec4",
    bg = "#18191a",
    gray = "#676e7b",
    pink = "#ee2c68",
    green = "#3dd177",
    light_green = "#82f4a2",
    cyan = "#64fcda",
    aqua = "#00b0ff",
    yellow = "#ffc900",
    light_yellow = "#ffe47e",
    purple = "#c678dd",
    peanut = "#f6d5a4",
    orange = "#d19a66",
    dark_pink = "#ff008c",
    dark_cyan = "#2b8db3",
    red = "#d54e53",
    dark_red = "#d03770",
    white = "#fefefe",
    light_gray = "#9ca3b2",
    dark_gray = "#313244",
    vulcan = "#383a3e",
    dark_green = "#2d2e27",
    dark_blue = "#26292f",
    black = "#1e2024",
    none = "NONE",
}

---Convert hex value to rgb
---@param color string
local function hex2rgb(color)
    color = string.lower(color)

    return {
        tonumber(color:sub(2, 3), 16),
        tonumber(color:sub(4, 5), 16),
        tonumber(color:sub(6, 7), 16),
    }
end

---@param fg string #foreground color
---@param bg string #background color
---@param alpha number #number between 0 and 1.
---@source: https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/util.lua#L9-L37
local function blend(fg, bg, alpha)
    local bg_rgb = hex2rgb(bg)
    local fg_rgb = hex2rgb(fg)

    local blend_channel = function(i)
        local ret = (alpha * fg_rgb[i] + ((1 - alpha) * bg_rgb[i]))

        return math.floor(math.min(math.max(0, ret), 255) + 0.5)
    end

    return ("#%02x%02x%02x"):format(blend_channel(1), blend_channel(2), blend_channel(3))
end

---@param alpha number #number between 0 and 1
function string:darken(alpha)
    return blend(self, "#000000", alpha)
end

---@param alpha number #number between 0 and 1
function string:lighten(alpha)
    return blend(self, "#ffffff", alpha)
end

---Get the hex value of a color
---@param name string #name of the color
---@param value any #value of the color
---@return string? #hex string or `nil` if invalid
local function get_hex_value(name, value)
    local type_ok, err = pcall(vim.validate, {
        ["colors(" .. name .. ")"] = { value, "string" },
    })

    if not type_ok then
        logs.error.notify(err)

        return nil
    end

    if value:lower() == "none" then
        return value
    end

    local rgb = vim.api.nvim_get_color_by_name(value)

    if rgb == -1 then
        logs.error.notify("colors(%s): %q is not a valid color", name, value)

        return nil
    end

    return ("#%06x"):format(rgb)
end

---@type palette
colors.extended = vim.deepcopy(colors.default)

for name, value in pairs(config.colors) do
    colors.extended[name] = get_hex_value(name, value)
end

return colors.extended
