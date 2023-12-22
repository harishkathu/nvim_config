local null_ls = require("null-ls")

local format = null_ls.builtins.formatting
local diag = null_ls.builtins.diagnostics
local comp = null_ls.builtins.completion

null_ls.setup({
    sources = {
        format.stylua,
        diag.eslint,
        comp.spell,
    },
})
