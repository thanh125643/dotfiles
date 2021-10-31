local cmd = vim.cmd
local exec = vim.api.nvim_exec
local fn = vim.fn
local g = vim.g
local opt = vim.opt
local o = vim.o
local wo = vim.wo
local bo = vim.bo

g.mapleader = ' ' -- change leader to a comma
opt.mouse = 'a' -- enable mouse support
opt.clipboard = 'unnamedplus' -- copy/paste to system clipboard
opt.swapfile = false

opt.number = true -- show line number
opt.relativenumber = true
opt.showmatch = true -- highlight matching parenthesis
opt.foldmethod = 'expr' -- enable folding (default 'foldmarker')
-- opt.colorcolumn = '80' -- line lenght marker at 80 columns
opt.splitright = true -- vertical split to the right
opt.splitbelow = true -- orizontal split to the bottom
opt.ignorecase = true -- ignore case letters when search
opt.smartcase = true -- ignore lowercase for the whole pattern
opt.errorbells = false -- Turn off errorbells
opt.scrolloff = 4
opt.foldexpr = fn['nvim_treesitter#foldexpr']()

-- remove whitespace on save
cmd [[au BufWritePre * :%s/\s\+$//e]]

opt.hidden = true -- enable background buffers
opt.history = 100 -- remember n lines in history
opt.lazyredraw = true -- faster scrolling
opt.synmaxcol = 240 -- max column for syntax highlight

opt.termguicolors = true -- enable 24-bit RGB colors
opt.background = 'dark'

cmd('colorscheme onedark')

opt.expandtab = true -- use spaces instead of tabs
opt.shiftwidth = 4 -- shift 4 spaces when tab
opt.tabstop = 4 -- 1 tab == 4 spaces
opt.softtabstop = 4
opt.smartindent = true -- autoindent new lines

cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

-- disable IndentLine for markdown files (avoid concealing)
cmd [[autocmd FileType markdown let g:indentLine_enabled=0]]

opt.completeopt = 'menuone,noselect,noinsert' -- completion options

-- nvimtree configuration
g.nvim_tree_ignore = {'.git', 'node_modules', '.cache'}
g.nvim_tree_gitignore = 1
g.nvim_tree_special_files = {['README.md'] = 1, Makefile = 1, MAKEFILE = 1}
g.nvim_tree_refresh_wait = 500
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
require('nvim-tree').setup {
    auto_close = true,
    lsp_diagnostics = true,
    update_cwd = true,
    view = {width = 50, auto_resize = true}
}
-- lualine configuration
require('lualine').setup {
    options = {theme = 'onedark', icons_enabled = true},
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    extensions = {'nvim-tree'}
}

-- treesitter configuration
require('nvim-treesitter.configs').setup {
    ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = {}, -- List of parsers to ignore installing
    highlight = {
        enable = true -- false will disable the whole extension
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm"
        }
    },
    indent = {enable = true},
    textobjects = {
        select = {
            enable = true,
            -- z- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner"
            }
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer'
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer'
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer'
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer'
            }

        },
        swap = {
            enable = true,
            swap_next = {["<leader>xp"] = "@parameter.inner"},
            swap_previous = {["<leader>xP"] = "@parameter.inner"}
        },
        lsp_interop = {
            enable = true,
            border = 'none',
            peek_definition_code = {
                ["<leader>pf"] = "@function.outer",
                ["<leader>pc"] = "@class.outer"
            }
        }

    },
    context_commentstring = {enable = true},
    refactor = {
        highlight_definitions = {enable = true},
        highlight_current_scope = {enable = true},
        smart_rename = {enable = true, keymaps = {smart_rename = "grr"}},
        navigation = {
            enable = true,
            keymaps = {
                goto_definition = "gnd",
                list_definitions = "gnD",
                list_definitions_toc = "gO",
                goto_next_usage = "<a-*>",
                goto_previous_usage = "<a-#>"
            }
        }
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        color = {
            '#E06C75', '#98C378', '#E5Co7B', '#61AFEF', '#C678DD', '#56B6C2'
        }
    },
    autotag = {enable = true},
    textsubjects = {
        enable = true,
        keymaps = {
            ['.'] = 'textsubjects-smart',
            [';'] = 'textsubjects-container-outer'
        }
    },
    autopairs = {enable = true}
}
require'treesitter-context'.setup {
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    throttle = true -- Throttles plugin updates (may improve performance)
}

-- telescope settings
require('telescope').setup {
    defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        -- ..
    },
    pickers = {
        find_files = {theme = "dropdown"},
        colorscheme = {theme = "dropdown"}
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case" -- or "ignore_case" or "respect_case"
        }
    }
}
require('telescope').load_extension('fzf')

-- vimwiki config
g.vimwiki_list = {
    {
        path = "~/.wiki",
        path_html = "~/.wikihtml",
        custom_wiki2html = '/.dotfile/nvim/.config/nvim/lua/nguyen/convert.py',
        syntax = 'markdown',
        ext = '.md'
    }
}
g.vimwiki_ext2syntax = {
    ['.md'] = 'markdown',
    ['.markdown'] = 'markdown',
    ['.mdown'] = 'markdown'
}
g.vimwiki_global_ext = 0

g.vimwiki_markdown_link_ext = 1
g.markdown_folding = 1
g.vimwiki_folding = 'custom'
g.vimwiki_filetypes = {'markdown'}

-- vim pandoc config
cmd([[augroup pandoc_syntax]])
cmd([[autocmd! FileType vimwiki set syntax=markdown.pandoc]])
cmd([[augroup END]])
g['pandoc#modules#enabled'] = {"folding"}
g['pandoc#folding#mode'] = 'syntax'
g.mkdp_filetypes = {'markdown', 'pandoc'}

-- indentline config
g.indentLine_char_list = {'|', '¦', '┆', '┊'}
g.indentLine_concealcursor = ''
g.indentLine_setColors = 0

-- cmp config
local cmp = require('cmp')
cmp.setup {
    snippet = {
        expand = function(args)
            -- For `luasnip` user.
            require('luasnip').lsp_expand(args.body)
        end
    },
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({select = true})
    },
    sources = {{name = 'nvim_lsp'}, {name = 'luasnip'}, {name = 'buffer'}}
}
-- autopairs config
local npairs = require("nvim-autopairs")
require("nvim-autopairs.completion.cmp").setup({
    map_cr = true, --  map <CR> on insert mode
    map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
    auto_select = true, -- automatically select the first item
    insert = false, -- use insert confirm behavior instead of replace
    map_char = { -- modifies the function or method delimiter by filetypes
        all = '(',
        tex = '{'
    }
})
npairs.setup({check_ts = true})

