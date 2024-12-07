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

    border = nil,
    cmd = { "nvim" },
    debounce = 250,
    debug = false,
    default_timeout = 5000,
    diagnostic_config = { -- see :help vim.diagnostic.config()
        underline = false,
        virtual_text = false,
        signs = true,
        update_in_insert = false,
        severity_sort = true,
    },
    diagnostics_format = "[#{c}] #{m} (#{s})",
    fallback_severity = vim.diagnostic.severity.ERROR,
    log_level = "warn",
    notify_format = "[null-ls] %s",
    on_attach = nil,
    on_init = nil,
    on_exit = nil,
    root_dir = require("null-ls.utils").root_pattern(".null-ls-root", "CMakeLists.txt", "Makefile", ".git"),
    root_dir_async = nil,
    should_attach = nil,
    temp_dir = nil,
    update_in_insert = false,
})
