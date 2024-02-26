local lsp = require("lsp-zero")

-- Mason setup
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'clangd',
        'cmake',
        'eslint',
        'lua_ls',
        'marksman', -- markdown
        'pyright',
        'rust_analyzer',
    },
    handlers = {
        lsp.default_setup,
    },
})

-- Gutter icons (default: E, W, H, I)
lsp.set_sign_icons({
    error = '',
    warn = '',
    hint = '',
    info = ''
})

-- Custom Keymaps
lsp.on_attach(function(_, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
    local opts = { buffer = bufnr, remap = false }

    -- vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
    -- vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    -- vim.keymap.set("n", "gI", function() vim.lsp.buf.implementation() end, opts)
    -- vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<F2>", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, opts)

    vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format({ timeout_ms = 5000 }) end, opts)
    vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action({ timeout_ms = 1000 }) end, opts)
    vim.keymap.set("n", "<leader>lws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

-- Disable schematic Tokens (soemthign like syantax highlighting i guess, not sure look it up)
--lsp.set_server_config({
--    on_init = function(client)
--        client.server_capabilities.semanticTokensProvider = nil
--    end,
--})

-- require('lspconfig').pyright.setup({
--     settings = {
--         pyright = {
--             -- disableLanguageServices = true,
--             -- disableOrganizeImports = true,
--             -- reportMissingModuleSource = "none",
--             reportMissingImports = "none",
--             -- reportUndefinedVariable = "none",
--             disableTaggedHints = true,
--         },
--         python = {
--             analysis = {
--                 typeCheckingMode = 'off',
--             },
--         },
--     },
-- })

-- At last setup the lsp with above configs
lsp.setup()

-- Few other configs
vim.diagnostic.config({
    -- virtual_text displays the warnigns in line
    virtual_text = false
})
