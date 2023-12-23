local default_colorscheme = "default"
local colorscheme = "catppuccin-mocha"
local scheme = "catppuccin"
local cp = require('catppuccin.palettes').get_palette()

-- Setup my colorscheme
local status_ok, sch = pcall(require, scheme)
if not status_ok then
    vim.notify(scheme .. " not found")
end

sch.setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = {         -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = true, -- disables setting the background color.
    show_end_of_buffer = true,     -- shows the '~' characters after the end of buffers
    term_colors = false,           -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = true,            -- dims the background color of inactive window
        shade = "light",
        percentage = 0.85,         -- percentage of the shade to apply to the inactive window
    },
    no_italic = false,             -- Force no italic
    no_bold = false,               -- Force no bold
    no_underline = false,          -- Force no underline
    styles = {                     -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" },   -- Change the style of comments
        conditionals = { "italic" },
        loops = { "italic" },
        functions = { "bold" },
        keywords = {},
        strings = {},
        variables = {},
        numbers = { "bold" },
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    integrations = {
        -- For more plugins integrations please visit (https://github.com/catppuccin/nvim#integrations)
        alpha = true,
        bufferline = {
            enable = true,
            italics = true,
            bolds = true,
        },
        cmp = true,
        gitsigns = true,
        gitgutter = false,
        mason = true,
        markdown = true,
        mini = {
            enabled = true,
            indentscope_color = "lavender",
        },
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
            },
            inlay_hints = {
                background = true,
            },
        },
        nvimtree = {
            enabled = false,
            show_root = true,
            transparent_panel = false,
        },
        treesitter = true,
        ts_rainbow = false,
        telescope = { enabled = true, },
        ufo = true,
        which_key = true,
    },
    color_overrides = {},
    custom_highlights = {
        BufferLineIndicatorSelected = { fg = cp.green },
        BufferLineModifiedSelected = { fg = cp.teal },
        BufferLineVisible = { fg = cp.pink, bg = cp.mantle },
        BufferLineIndicatorVisible = { bg = cp.mante },
        BufferLineBackcrust = { fg = cp.surface1, bg = cp.mantle },
    },
})


-- Set colorscheme
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    vim.cmd.colorscheme = default_colorscheme
    return
end
