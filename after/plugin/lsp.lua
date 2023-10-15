local lsp = require("lsp-zero")
local cmp = require("cmp")
--local cmp_format = lsp.cmp_format()

lsp.preset("recommended")

-- Mason setup
--require('mason').setup({})
--require('mason-lspconfig').setup({
lsp.ensure_installed = ({
      'clangd',
      'cmake',
      'lua_ls',
      'marksman', -- markdown
      'pyright',
      'rust_analyzer',
  })
--  ,
--  handlers = {
--    lsp.default_setup,
--  },
--})

-- Fix Undefined global 'vim'
-- local lua_opts = lsp.nvim_lua_ls()
--require('lspconfig').lua_ls.setup{
--settings = {
--    Lua = {
--      diagnostics = {
--        -- Get the language server to recognize the `vim` global
--        globals = {'vim'},
--      },
--    },
--  },
--}

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = '',
        warn = '',
        hint = '',
        info = ''
    }
})

lsp.on_attach(function(_, bufnr)
  local opts = {buffer = bufnr, remap = false}

  --vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  --vim.keymap.set("n", "gI", function() vim.lsp.buf.implementation() end, opts)
  --vim.keymap.set("n", "gr", function() vim.lsp.buf.reference() end, opts)
  vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format() end, opts)
  vim.keymap.set("n", "<leader>lws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

--local lua_opts = lsp.nvim_lua_ls()
--require('lspconfig').lua_ls.setup(lua_opts)
--local cmp_format = require("lsp-zero").cmp_format()

cmp.setup ({
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
  preselect = 'item',
  completion = {
      completeopt = {'menu,menuone,noinsert'},
  },
  --formatting = cmp_format,
  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-u>"] = cmp.mapping.scroll_docs(-1),
    ["<C-d>"] = cmp.mapping.scroll_docs(1),
  --  ["<C-Space>"] = cmp.mapping.complete(),
  --  ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
  --  -- Accept currently selected item. If none selected, `select` first item.
  --  -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  --  ["<Tab>"] = cmp.mapping(function(fallback)
  --    if cmp.visible() then
  --      cmp.select_next_item()
  --    elseif luasnip.expandable() then
  --      luasnip.expand()
  --    elseif luasnip.expand_or_jumpable() then
  --      luasnip.expand_or_jump()
  --    elseif check_backspace() then
  --      fallback()
  --    else
  --      fallback()
  --    end
  --  end, {
  --    "i",
  --    "s",
  --  }),
  --  ["<S-Tab>"] = cmp.mapping(function(fallback)
  --    if cmp.visible() then
  --      cmp.select_prev_item()
  --    elseif luasnip.jumpable(-1) then
  --      luasnip.jump(-1)
  --    else
  --      fallback()
  --    end
  --  end, {
  --    "i",
  --    "s",
  --  }),
  }),
  --confirm_opts = {
  --  behavior = cmp.ConfirmBehavior.Replace,
  --  select = false,
  --},
  --window = {
  --  documentation = {
  --    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  --  },
  --},
  --experimental = {
  --  ghost_text = false,
  --  native_menu = false,
  --},
})

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

