local null_ls = require("null-ls")

local format = null_ls.builtins.formatting
local diag = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local comp = null_ls.builtins.completion
local hover = null_ls.builtins.hover

null_ls.setup({
    sources = {
        format.black,
        format.prettier,
        format.stylua,
        format.yamlfmt,

        diag.markdownlint,
        diag.pylint,
        diag.cpplint,
        diag.stylelint,
        diag.yamllint,
        diag.codespell,

        comp.tags,

        code_actions.gitsigns,
        code_actions.shellcheck,
        code_actions.proselint,
        code_actions.refactoring,

        hover.dictionary,
        hover.printenv,
    },
})
