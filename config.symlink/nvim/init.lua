-- Plugins

vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
    use('christoomey/vim-tmux-navigator')
    use('jeremiahkellick/jkellick-one-dark-vim')
    use('mbbill/undotree')
    use({
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        requires = {{'nvim-lua/plenary.nvim'}, {'BurntSushi/ripgrep'}}
    })
    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use('saadparwaiz1/cmp_luasnip')
    use('tpope/vim-fugitive')
    use ({
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
            {'neovim/nvim-lspconfig'},
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},
        }
    })
    use('wbthomason/packer.nvim')
end)

-- Editor settings

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.cinoptions = ':0l1'
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true

vim.opt.colorcolumn = '101'
vim.opt.cursorline = true
vim.opt.incsearch = true
vim.opt.scrolloff = 8
-- vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.updatetime = 50
vim.opt.wrap = false

vim.cmd('colorscheme jkellickonedark')

-- Keymaps

vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
vim.keymap.set('n', '<leader>,', vim.cmd.nohlsearch)

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzb')

vim.keymap.set({'n', 'v'}, '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')

vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', {silent = true})

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

vim.keymap.set('n', '<leader>o', 'o<Esc>')
vim.keymap.set('n', '<leader>O', 'O<Esc>')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})

vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

vim.keymap.set('i', '<C-BS>', '<C-w>')
vim.keymap.set('i', '<C-h>', '<C-w>')
vim.keymap.set('i', '<C-o>', '<Esc>O')

local ls = require('luasnip')
vim.keymap.set({"i"}, "<C-l>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-j>", function() ls.jump(1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-k>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set('x', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('x', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('x', '<leader>p', '"_dP')

-- Treesitter
require('nvim-treesitter.configs').setup({
    ensure_installed = {'c', 'lua', 'vim', 'vimdoc', 'query'},
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
})

-- LSP

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({buffer = bufnr})
end)

local lsc = require('lspconfig')

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {'clangd'},
    handlers = {
        function(server_name)
            lsc[server_name].setup({})
        end,
    }
})

-- Autocomplete

local cmp = require('cmp')

cmp.setup({
    sources = {
        {name = 'nvim_lsp'},
    },
    mapping = {
        ['<C-y>'] = cmp.mapping.confirm({select = true}),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<Up>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
        ['<Down>'] = cmp.mapping.select_next_item({behavior = 'select'}),
        ['<C-p>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item({behavior = 'insert'})
            else
                cmp.complete()
            end
        end),
        ['<C-n>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_next_item({behavior = 'insert'})
            else
                cmp.complete()
            end
        end),
    },
    snippet = {
        expand = function(args)
            ls.lsp_expand(args.body)
        end,
    },
})

-- Snippets

ls.add_snippets('all', {
    ls.snippet({trig = 'struct%.(%w+)', regTrig = true}, {
        ls.function_node(function(_, snip)
            return {'typedef struct ' .. snip.captures[1] .. ' {', '\t'}
        end, {}),
        ls.insert_node(0),
        ls.function_node(function(_, snip)
            return {'', '} ' .. snip.captures[1] .. ';'}
        end, {}),
    }),
    ls.snippet({trig = 'enum%.(%w+)', regTrig = true}, {
        ls.function_node(function(_, snip)
            return {'typedef enum ' .. snip.captures[1] .. ' {', '\t'}
        end, {}),
        ls.insert_node(0),
        ls.function_node(function(_, snip)
            return {'', '} ' .. snip.captures[1] .. ';'}
        end, {}),
    }),
})

-- Undotree settings

vim.g.undotree_RelativeTimestamp = 0
