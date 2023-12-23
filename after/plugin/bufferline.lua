local bufferline = require("bufferline")
local macchiato = require("catppuccin.palettes").get_palette "macchiato"

bufferline.setup({
    highlights = require("catppuccin.groups.integrations.bufferline").get {
        styles = { "italic", "bold" },
        custom = {
            all = {
                fill = { bg = "#000000" },
            },
            macchiato = {
                background = { fg = macchiato.text },
            },
            latte = {
                background = { fg = "#000000" },
            },
        },
    },
    options = {
        themable = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        separator_style = "thin", -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' }
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        hover = {
            enabled = true,
            delay = 100,
            reveal = { 'close' },
        },
        groups = {
            items = {
                -- To pin a buffer use :BufferLineTogglePin
                require('bufferline.groups').builtin.pinned:with({ icon = "" })
            }
        },
        diagnostics = false, -- "nvim_lsp",
        diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or ""
            return icon .. ' ' .. count
        end,
        offsets = {
            {
                filetype = "NvimTree",
                text = "Tree 󰙅",
                padding = 1,
            }
        }
    },
})
