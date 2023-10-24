local default_colorscheme = "default"
local colorscheme = "catppuccin-frappe"
local scheme = "catppuccin"

-- Setup my colorscheme
local status_ok, sch = pcall(require, scheme)
if not status_ok then
    vim.notify(scheme .. " not found")
end

sch.setup({
    flavour = "macchiato", -- latte, frappe, macchiato, mocha
    background = {         -- :h background
        light = "latte",
        dark = "macchiato",
    },
    transparent_background = true, -- disables setting the background color.
    show_end_of_buffer = true,     -- shows the '~' characters after the end of buffers
    term_colors = false,           -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = true,            -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.10,         -- percentage of the shade to apply to the inactive window
    },
    no_italic = false,             -- Force no italic
    no_bold = false,               -- Force no bold
    no_underline = false,          -- Force no underline
    styles = {                     -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" },   -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = { "bold" },
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
        -- For more plugins integrations please visit (https://github.com/catppuccin/nvim#integrations)
        mason = true,
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        ts_rainbow = true,
        notify = false,
        mini = false,
        telescope = { enabled = true, },
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
    },
})


-- Set colorscheme
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    vim.cmd.colorscheme = default_colorscheme
    return
end
