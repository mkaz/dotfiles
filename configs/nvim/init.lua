----------------------------------------------------------------------------
-- init.vim
-- From: https://github.com/mkaz/dotfiles
-- ----------------------------------------------------------------------------

-- Use vim-plug to manage plugins
-- See: https://github.com/junegunn/vim-plug

local Plug = vim.fn['plug#']
vim.call('plug#begin' ,'~/.config/plugged')
Plug 'cloudhead/neovim-fuzzy'          -- fuzzy finder via fzy
Plug 'editorconfig/editorconfig-vim'   -- support editorconfig settings
Plug 'edeneast/nightfox.nvim'          -- colorscheme
Plug 'junegunn/vim-slash'              -- search highlighting
Plug 'maxmellon/vim-jsx-pretty'        -- pretty jsx
Plug 'nvim-lualine/lualine.nvim'       -- Statusline
Plug 'prettier/vim-prettier'
Plug 'rust-lang/rust.vim'              -- rusty!
Plug 'tommcdo/vim-lion'                -- alignment motion
Plug 'tpope/vim-commentary'            -- comment code
Plug 'tpope/vim-markdown'              -- markdown
Plug 'tpope/vim-surround'              -- surround motion
vim.call('plug#end')

-- Settings
vim.cmd('colorscheme nightfox')

vim.opt.tabstop     = 4
vim.opt.shiftwidth  = 4
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

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase  = true

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

-- Unhighlight Search using ,SPC
-- vim-slash helps by unhighlighting on move
keymap('n', '<Leader><Space>', ':nohlsearch<CR>', opts)

-- F3 toggle wrap
keymap('n', '<F2>', ':set wrap!<CR>', opts)
keymap('i', '<F2>', ':set wrap!<CR>', opts)

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

-- =========================================================
-- File Formats
-- =========================================================

-- Run Prettier on save
vim.api.nvim_create_autocmd('BufWritePre', {
	pattern = '*.js',
	command = 'Prettier',
})

-- Markdown
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
	pattern = '*.md',
	callback = function()
		vim.opt.wrap = true
		vim.opt.linebreak = true
	end
})

vim.g.markdown_fenced_languages = {'javascript', 'js=javascript', 'json=javascript', 'php', 'python'}

-- Rusty!
vim.g.rustfmt_autosave = 1

-- :w!! to save with sudo
vim.cmd('ca w!! w !sudo tee >/dev/null "%"')


-- =========================================================
-- Plugin Settings
-- =========================================================


-- Lualine
require('lualine').setup {
	options = { theme = 'onelight' },
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch'},
		lualine_c = {'filename'},
		lualine_x = {'filetype'},
		lualine_y = {},
		lualine_z = {'location'}
	},
}

-- Prettier

vim.g['prettier#autoformat'] = 1
vim.g['prettier#autoformat_require_pragma'] = 0

