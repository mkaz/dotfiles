----------------------------------------------------------------------------
-- init.vim
-- From: https://github.com/mkaz/dotfiles
-- ----------------------------------------------------------------------------

-- Use vim-plug to manage plugins
-- See: https://github.com/junegunn/vim-plug

local Plug = vim.fn['plug#']
vim.call('plug#begin' ,'~/.config/plugged')
Plug 'bluz71/vim-nightfly-colors'
Plug 'cloudhead/neovim-fuzzy'          -- fuzzy finder via fzy
Plug 'dcampos/nvim-snippy'             -- snippets
Plug 'editorconfig/editorconfig-vim'   -- support editorconfig settings
Plug 'junegunn/vim-slash'              -- search highlighting
Plug 'luukvbaal/nnn.nvim'
Plug 'maxmellon/vim-jsx-pretty'        -- pretty jsx
Plug 'nvim-lualine/lualine.nvim'       -- Statusline
Plug 'psf/black'
Plug 'tommcdo/vim-lion'                -- alignment motion
Plug 'tpope/vim-commentary'            -- comment code
Plug 'tpope/vim-markdown'              -- markdown
Plug 'tpope/vim-surround'              -- surround motion
Plug 'xolox/vim-colorscheme-switcher'  -- utility for switch colorscheme with F8
Plug 'xolox/vim-misc'
vim.call('plug#end')

-- Settings
vim.cmd('colorscheme nightfly')

vim.opt.tabstop     = 4
vim.opt.shiftwidth  = 4
vim.opt.expandtab   = true
vim.opt.fileformat  = 'unix'
vim.opt.fileformats = 'unix'
vim.opt.wrap        = false
vim.opt.linebreak   = true
vim.opt.number      = true    -- show line numbers
vim.opt.showmode    = false
vim.opt.scrolloff   = 2
vim.opt.backup      = false   -- no backups
vim.opt.mouse       = 'a'     -- enable mouse support
vim.opt.visualbell  = false   -- shhhh
vim.opt.errorbells  = false   -- shhhh
vim.opt.termguicolors = true

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase  = true

vim.opt.listchars  = 'tab:▸-,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»'

vim.g.python3_host_prog = '/opt/homebrew/bin/python3'


-- KEYBINDINGS
-- =========================================================

vim.g.mapleader = ','

-- keymap options
local opts = { noremap = true, silent = true, }
local shh  = { silent = true }
local keymap = vim.api.nvim_set_keymap

-- Edit config file
keymap('n', '<Leader>re', ':edit $MYVIMRC<CR>', opts)
keymap('n', '<Leader>rs', ':source $MYVIMRC<CR>', opts)

-- move updown by visual (wrapped) lines
keymap('n', 'j', 'gj', opts)  -- move down wrapped lines visually
keymap('n', 'k', 'gk', opts)  -- move up wrapped lines visually

keymap('n', '<Leader>/', ':Commentary<CR>', shh) -- comment line using vim commentary
keymap('v', '<Leader>/', ':Commentary<CR>', shh) -- comment line using vim commentary

-- Surround with Quote uses vim-surround
keymap('n', "<Leader>'", "ysiw'", shh)
keymap('n', '<Leader>"', 'ysiw"', shh)

-- Fuzzy finder
keymap('n', '<Leader>p', ':FuzzyOpen<CR>', opts)

-- Telescope file
keymap('n', '<F2>', ":NnnExplorer<CR>", opts)

-- Unhighlight Search using ,SPC
-- vim-slash helps by unhighlighting on move
keymap('n', '<Leader><Space>', ':nohlsearch<CR>', opts)

-- F3 toggle wrap
keymap('n', '<F3>', ':set wrap!<CR>', opts)
keymap('i', '<F3>', ':set wrap!<CR>', opts)

-- Add semi colon at end of line
keymap('n', '<Leader>;', 'g_a;<Esc>', opts)

-- Bubble single lines
keymap('n', '<M-Up>',   ':m .-2<CR>', opts)
keymap('n', '<M-Down>', ':m  .+1<CR>', opts)

-- Bubble multiple lines
keymap('v', '<M-Up>',  '@=\'"zxk"zP`[V`]\'<CR>', opts)
keymap('v', '<M-Down>', '@=\'"zx"zp`[V`]\'<CR>', opts)

-- Buffer Navigation
keymap('n', '<Leader>n', ':enew<CR>',  opts)  -- new buffer
keymap('n', '<Tab>',     ':bnext<CR>', opts)  -- next buffer
keymap('n', '<S-Tab>',   ':bprev<CR>', opts)  -- previous buffer
keymap('n', '<Leader>3', ':b#<CR>',    opts)  -- recent buffer
keymap('n', '<Leader>a', ':only<CR>',  opts)  -- only buffer
keymap('n', 'Q',         ':bd!<CR>',   opts)  -- close buffer

-- :w!! to save with sudo
vim.cmd('ca w!! w !sudo tee >/dev/null "%"')

-- =========================================================
-- File Formats
-- =========================================================

-- Markdown
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
    pattern = '*.md',
    callback = function()
    vim.opt.wrap = true
    vim.opt.linebreak = true
    end
})

vim.g.markdown_fenced_languages = {'javascript', 'js=javascript', 'json=javascript', 'php', 'python'}

-- Python
vim.api.nvim_create_autocmd({'BufWritePre'}, {
    pattern = '*.py',
    command = "Black"
})



-- =========================================================
-- Plugin Settings
-- =========================================================


-- Lualine
require('lualine').setup {
    options = { theme = 'nightfly' },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch'},
        lualine_c = {'filename'},
        lualine_x = {'filetype'},
        lualine_y = {},
        lualine_z = {'location'}
    },
}

-- Snippy
require('snippy').setup({
    mappings = {
        is = {
            ['<Tab>'] = 'expand_or_advance',
            ['<S-Tab>'] = 'previous',
        },
        nx = {
            ['<leader>x'] = 'cut_text',
        },
    },
})

-- NNN
require("nnn").setup()

