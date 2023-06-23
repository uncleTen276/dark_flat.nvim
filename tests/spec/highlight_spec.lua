describe("Highlight", function()
    local highlight = require "dark_flat.themes.highlight"
    local colors = require "dark_flat.colors"

    local default = highlight:new {
        Normal = { fg = colors.fg, bg = colors.bg },
    }

    local extended = default:extend {
        Boolean = { fg = colors.aqua },
    }

    it("should create new instance", function()
        assert.are_not.same(default, extended)
    end)

    it("should be able to extend default groups", function()
        local expected = highlight:new {
            Normal = { fg = colors.fg, bg = colors.bg },
            Boolean = { fg = colors.aqua },
        }

        assert.are.same(expected, extended)
    end)
end)
