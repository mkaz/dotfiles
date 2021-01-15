" ----------------------------------------------------------------------------
" init.vim
" From: https://github.com/mkaz/dotfiles
" ----------------------------------------------------------------------------

" use vim-plug to manage plugins
" See: https://github.com/junegunn/vim-plug

call plug#begin('~/.config/plugged')
Plug 'airblade/vim-gitgutter'	      " git gutter
Plug 'cohama/agit.vim'                " browse git history
Plug 'editorconfig/editorconfig-vim'  " support editorconfig settings
Plug 'fatih/vim-go'                   " golang support
Plug 'itchyny/lightline.vim'          " fancy status line
Plug 'junegunn/fzf',  { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'               " fuzzy search
Plug 'junegunn/goyo.vim'              " writing
Plug 'junegunn/vim-slash'             " search highlighting
Plug 'mhartington/oceanic-next'       " colors
Plug 'prettier/vim-prettier'
Plug 'rhysd/git-messenger.vim'        " inline git blame
Plug 'reedes/vim-wordy'               " grammar check
Plug 'rust-lang/rust.vim'             " rusty!
Plug 'tommcdo/vim-lion'               " alignment motion
Plug 'tpope/vim-commentary'           " comment code
Plug 'tpope/vim-markdown'             " markdown
Plug 'tpope/vim-obsession'            " session control
Plug 'tpope/vim-sensible'             " default settings
Plug 'tpope/vim-surround'             " surround motion
call plug#end()

" Settings
let mapleader=","

" Colors
colorscheme OceanicNext

" Whitespace stuff
set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set encoding=utf-8

" default wrap lines, break at word
set wrap!
set linebreak

" hidden characters
set listchars=tab:▸\ ,eol:¬

" Display
set number            " show line numbers
set noshowmode        " hide mode, its in status

" Operation
set scrolloff=2       " scroll 2 lines top/bottom
set hidden            " allows to switch to/from unsaved buffers
set nobackup

" Disabled for Security
" See: https://github.com/numirias/security/blob/master/doc/2019-06-04_ace-vim-neovim.md
set modeline          " use modeline override
set modelines=2       " check last two lines
set mouse=a           " enable mouse support

" move updown by visual (wrapped) lines
noremap j gj
noremap k gk

let g:python3_host_prog = '/usr/bin/python3'

" shhhh
set novisualbell
set noerrorbells

" Folding
set foldenable               " enable folding
set foldlevelstart=10        " start with expanded
set foldnestmax=10           " max number of nested folds

" space open/close folds
nnoremap <space> za

" Searching
set ignorecase
set smartcase

set undolevels=1000

set wildmode=longest,list,full
set wildignore+=.hg,.git,.svn         "version control
set wildignore+=*.rbc,*.class,*.pyc   "compiled formats
set wildignore+=*.DS_Store            "OSX files
set wildignore+=*__pycache__

" fzf and ripgrep
nnoremap <Leader>p :Files<CR>
nnoremap <Leader>, :Buffers<CR>
noremap <Leader>f :Rg<space>

" File Specific

augroup configgroup

    autocmd!

    " Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
    autocmd BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby

    " Python File Types (use spaces)
    autocmd FileType python map <Leader>r :w<CR>:!python %<CR>

    " PHP File Types (WordPress, use tabs)
    autocmd FileType php set noexpandtab

    " golang
    autocmd BufRead,BufNewFile *.go set filetype=go makeprg=go\ build
    autocmd FileType go nmap <Leader>r <Plug>(go-run)
    autocmd FileType go nmap <Leader>b :make<CR>
    autocmd FileType go nmap <Leader>t :terminal go test<CR>
    let g:go_fmt_command = "goimports"

	" rust
	autocmd FileType rust nmap <Leader>b :terminal cargo run<CR>
	autocmd FileType rust nmap <Leader>t :call RunRustTest() <CR>
	let g:rustfmt_autosave = 1


    " Templates
    autocmd BufRead,BufNewFile *.{tpl,eco} set ft=html

    " Remember last location in file
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

    " Default wrap markdown
    autocmd BufRead,BufNewFile *.md :Wrap

	" Remove trailing space on write
	autocmd BufWritePre * %s/\s\+$//e

augroup END

function! RunRustTest()
	set splitbelow
	exec winheight(0)/2."split" | terminal cargo test "%:t:r"
endfunction

" Key Bindings

" Force close all the things
nnoremap ZQ :qa!<CR>

" :w!! to save with sudo
ca w!! w !sudo tee >/dev/null "%"

" Unhighlight Search using ,SPC
" vim-slash helps by unhighlighting on move
noremap <Leader><Space> :nohlsearch<CR>

" Toggle comments using vim-commentary
map <Leader>/ gcc


" Buffer Navigation
nnoremap <Leader>n :enew<CR>  " new buffer
nnoremap <Tab> :bnext<CR>     " next buffer
nnoremap <S-Tab> :bprev<CR>   " previous buffer
nnoremap <Leader>3 :b#<CR>    " recent buffer
nnoremap <Leader>a :only<CR>  " only buffer
nnoremap Q :bd!<CR>           " close buffer

" Bubble single lines
nnoremap <C-Up> :m .-2<CR>
nnoremap <C-Down> :m  .+1<CR>

" Bubble multiple lines
vnoremap <silent> <C-Up>  @='"zxk"zP`[V`]'<CR>
vnoremap <silent> <C-Down>  @='"zx"zp`[V`]'<CR>

" Surround with Quote uses vim-surround
nmap <Leader>' ysiw'
nmap <Leader>" ysiw"

" Map F1 to ESC
noremap <F1> <Esc>
inoremap <F1> <Esc>

" F2 to toggle wrap
noremap <F2> :set wrap!<CR>
inoremap <F2> :set wrap!<CR>

" F3 to toggle whitespace
noremap <F3> :set list!<CR>

" Insert Date
:nnoremap <F4> "=strftime("%A, %Y-%m-%d %I:%M%P ")<CR>P
:inoremap <F4> <C-R>=strftime("%A, %Y-%m-%d %I:%M%P ")<CR>

" F5 to toggle Spellcheck
:noremap <F5> :setlocal spell! spelllang=en_us<CR>

" Add semi colon at end of line
noremap <Leader>; g_a;<Esc>

" Use K to 'krack' a line, opposite of J
nnoremap K i<CR><Esc>k$

" Add Spaces inside parentheses, WordPress Style
noremap <Leader>o ci(<space><space><Esc>hp

" Edit config file
nnoremap <Leader>re :edit $MYVIMRC<CR>
nnoremap <Leader>rs :source $MYVIMRC<CR>

" Run Hastie
noremap <Leader>h :terminal hastie<CR>

" :Wrap command
command! -nargs=* Wrap set wrap linebreak nolist

command! Vmake silent w | silent make | unsilent redraw! | cwindow
nnoremap <Leader>m :Vmake<CR>

" Plugin Settings

" Lightline
let g:lightline = { 'colorscheme': 'oceanicnext', 'active' : { 'left' : [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified', ] ], 'right' : [ [ 'lineinfo' ], [ 'filetype' ], [ 'wordcount' ], ] }, 'component': { 'buffernum': '%n' }, 'component_function': { 'wordcount': 'WordCount' }, }

" Goyo
noremap <F8> :Goyo<CR>
let g:goyo_width = 70

" Markdown
let g:markdown_fenced_languages = ['javascript', 'js=javascript', 'json=javascript', 'php', 'python' ]

