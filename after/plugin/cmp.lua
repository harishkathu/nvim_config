local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local cmp_format = require('lsp-zero').cmp_format()

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'nvim_lua' },
        { name = 'buffer' },
        { name = 'path' },

        { name = 'emoji' },
        { name = 'nerdfont' },
        {
            name = 'latex_symbols',
            option = {
                strategy = 0,
            },
        },
    },
    mapping = cmp.mapping.preset.insert({
        --['<C-k>'] = cmp.mapping.select_prev_item(),
        --['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-j>'] = cmp.mapping.scroll_docs(-1),
        ['<C-k>'] = cmp.mapping.scroll_docs(1),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<Tab>'] = cmp_action.luasnip_supertab(),
        ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
    }),
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = cmp_format,
})

-- For nvim cmdline completions
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        {
            name = 'cmdline',
            option = {
                ignore_cmds = {'Man', '!'}
            }
        }
    })
})
