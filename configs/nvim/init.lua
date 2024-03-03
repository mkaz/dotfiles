----------------------------------------------------------------------------
-- init.vim
-- From: https://github.com/mkaz/dotfiles
-- ----------------------------------------------------------------------------

-- Use vim-plug to manage plugins
-- See: https://github.com/junegunn/vim-plug

-- disable default file browser
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local Plug = vim.fn['plug#']
vim.call('plug#begin' ,'~/.config/plugged')
Plug 'cloudhead/neovim-fuzzy'          -- fuzzy finder via fzy
Plug 'dcampos/nvim-snippy'             -- snippets
Plug 'editorconfig/editorconfig-vim'   -- support editorconfig settings
Plug 'joshdick/onedark.vim'            -- color
Plug 'junegunn/vim-slash'              -- search highlighting
Plug 'maxmellon/vim-jsx-pretty'        -- pretty jsx
Plug 'nvchad/nvterm'         -- tree
Plug 'nvim-tree/nvim-tree.lua'         -- tree
Plug 'nvim-tree/nvim-web-devicons'     -- tree icons
Plug 'PeterRincker/vim-searchlight'    -- highlight current search so can see cursor
Plug 'psf/black'
Plug 'tommcdo/vim-lion'                -- alignment motion
Plug 'tpope/vim-commentary'            -- comment code
Plug 'tpope/vim-markdown'              -- markdown
Plug 'tpope/vim-surround'              -- surround motion
Plug 'vimwiki/vimwiki'
vim.call('plug#end')


vim.opt.tabstop     = 4
vim.opt.shiftwidth  = 4
vim.opt.expandtab   = true
vim.opt.fileformat  = 'unix'
vim.opt.fileformats = 'unix'
vim.opt.wrap        = false
vim.opt.linebreak   = true
vim.opt.number      = true    -- show line numbers
vim.opt.showmode    = true    -- show insert/normal mode
vim.opt.scrolloff   = 2
vim.opt.backup      = false   -- no backups
vim.opt.mouse       = 'vi'    -- enable mouse support
vim.opt.visualbell  = false   -- shhhh
vim.opt.errorbells  = false   -- shhhh
vim.opt.termguicolors = false
vim.opt.foldenable = false

-- Settings
vim.cmd('colorscheme onedark')

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase  = true

vim.opt.listchars  = 'tab:▸-,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»'

vim.g.python3_host_prog = '/Library/Frameworks/Python.framework/Versions/3.11/bin/python3'


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
vim.cmd('let g:fuzzy_rootcmds = [ ["git", "rev-parse", "--show-toplevel"] ]')
keymap('n', '<Leader>p', ':FuzzyOpen<CR>', opts)


-- Map F1 to ESC to avoid miss hits
keymap('i', '<F1>', "<ESC>", opts)
keymap('n', '<F1>', "<ESC>", opts)

-- Telescope file
keymap('n', '<F2>', ":NvimTreeOpen<CR>", opts)

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

keymap('n', '<Leader>b', ':lua require("nvterm.terminal").send("py " .. vim.fn.expand("%"), "float")<CR>', opts)

-- :w!! to save with sudo
vim.cmd('ca w!! w !sudo tee >/dev/null "%"')

-- =========================================================
-- File Formats
-- =========================================================

-- See ~/.config/nvim/ftplugin for language specific settings


-- =========================================================
-- Plugin Settings
-- =========================================================

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
-- require("nnn").setup({
--     explorer = {
--         width = 48,
--     },
-- })

--- NvimTree
require("nvim-tree").setup({
    filters = {
        custom = { ".git", "__pycache__", "__init__.py"}
    },
    git = {
        enable = false
    },
    renderer = {
        icons = {
            show = {
                folder_arrow = false,
            },
        },
    },
})

require("nvterm").setup()


