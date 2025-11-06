local configs = require("nvim-treesitter.configs")

require("nvim-treesitter.install").prefer_git = false
require('nvim-treesitter.install').compilers = { vim.fn.getenv('NVIM_CC'), "clang", "gcc", "cc", "cl", "zig", vim.fn.getenv('CC') }

configs.setup {
    ensure_installed = {
        "bash",
        "c",
        "cmake",
        "comment",
        "cpp",
        "css",
        "csv",
        "dockerfile",
        "doxygen",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "glsl",
        "html",
        "htmldjango",
        "http",
        "java",
        "javadoc",
        "javascript",
        "json",
        "json5",
        "JSON with commets",
        "linkerscript",
        "llvm",
        "lua",
        "luadoc",
        "lua patterns",
        "luau",
        "make",
        "markdown",
        "markdown_inline",
        "ninja",
        "objc",
        "objdump",
        "perl",
        "powershell",
        "printf",
        "python",
        "regex",
        "pip requirements",
        "rust",
        "sql",
        "ssh_config",
        "tmux",
        "todotxt",
        "typescript",
        "vimdoc",
        "xml",
        "yaml"
        },
    sync_install = true,
    auto_install = false,
    ignore_install = { "" }, -- List of parsers to ignore installing
    highlight = {
        enable = true,       -- false will disable the whole extension
        disable = { "" },    -- list of language that will be disabled
        additional_vim_regex_highlighting = false,

    },
    indent = { enable = true, disable = { "yaml" } },

    -- Autopairs with TS (https://github.com/windwp/nvim-autopairs)
    autopairs = {
        enable = true,
    },

    -- Comment strign with TS (https://github.com/JoosepAlviste/nvim-ts-context-commentstring)
    context_commentstring = {
        enable = false,
    },

    -- TS rainbow indent [archived] (https://github.com/p00f/nvim-ts-rainbow)
    rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    },

    -- TS Playground (https://github.com/nvim-treesitter/playground)
    playground = {
        enable = true,
        disable = {},
        updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
        },
    }
}
