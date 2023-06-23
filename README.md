<div align="center">
  <h1>
     Dark Flat Nvim
  </h1>
    Based on the amazing <a href="https://github.com/QuentinWatt/dark-flat-iterm-colors">Dark Flat Iterm2 </a> terminal theme.
</div>

</br>

![demo](https://github.com/sekke276/dark_flat.nvim/assets/72869134/c908aa85-4320-41bc-95bc-4c3831f2f405)

<p align = "center"><b>Normal background</b></p>

<br />

## :rocket: Installation

```lua
{"sekke276/dark_flat.nvim"}
```

### Requirement

- Neovim >= 0.9.1
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for better syntax highlighting (optional) 😇

## :gear: Setup

```lua
vim.cmd.colorscheme "dark_flat"
```

### Options

| Option        | Description                   | Type                       |
| ------------- | ----------------------------- | -------------------------- |
| `transparent` | enable transparent background | `boolean`                  |
| `colors`      | custom colors                 | `table<string, string>`    |
| `themes`      | custom highlight groups       | `function(colors): tables` |
| `italics`     | enable italics                | `boolean`                  |

### Default

```lua
require("dark_flat").setup({
    transparent = false,
    colors = {},
    themes = function(colors)
        return {}
    end,
    italics = true,
})
```

### Customization example

#### Available colors and themes

1. [colors](lua/dark_flat/colors.lua#L7)
2. [themes](lua/dark_flat/themes/groups.lua#L6)

#### Example

```lua
require("dark_flat").setup({
    transparent = true,  -- enable transparent window
    colors = {
        lmao = "#ffffff", -- add new color
        pink = "#ec6075", -- replace default color
    },
    themes = function(colors)
        -- change highlight of some groups,
        -- the key and value will be passed respectively to "nvim_set_hl"
        return {
            Normal = { bg = colors.lmao },
            DiffChange = { fg = colors.white:darken(0.3) },
            ErrorMsg = { fg = colors.pink, standout = true },
            ["@lsp.type.keyword"] = { link = "@keyword" }
        }
    end,
    italics = false, -- disable italics
})
```

## :eyes: Inspiration

- [dark-flat-item-colors](https://github.com/QuentinWatt/dark-flat-iterm-colors)
- [one_monokai.nvim](https://github.com/cpea2506/one_monokai.nvim)

