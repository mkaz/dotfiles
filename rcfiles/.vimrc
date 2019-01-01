" ----------------------------------------------------------------------------
" Vimrc
" From: https://github.com/mkaz/dotfiles
"
" Props to:
"
"   * Derek Wyatt, http://derekwyatt.org/
"   * Vimcasts, http://vimcasts.org/
"
"   * Damien Conway, More Instantly Better Vim
"     http://www.youtube.com/watch?v=aHm36-na4-4
"
"   * Doug Black
"     https://dougblack.io/words/a-good-vimrc.html
"
"   * /r/vim on Reddit
"
" ----------------------------------------------------------------------------

" use vim-plug to manage plugins
" See: https://github.com/junegunn/vim-plug

call plug#begin('~/.config/plugged')
Plug 'airblade/vim-gitgutter'         " git in the gutter
Plug 'cohama/agit.vim'                " browse git history
Plug 'editorconfig/editorconfig-vim'  " support editorconfig settings
Plug 'fatih/vim-go'                   " golang support
Plug 'itchyny/lightline.vim'          " fancy status line
Plug 'junegunn/fzf',  { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'               " fuzzy search
Plug 'junegunn/goyo.vim'              " writing
Plug 'junegunn/vim-slash'             " search highlighting
Plug 'mattn/calendar-vim'             " calendar works with wiki
Plug 'mhartington/oceanic-next'       " pretty colors
Plug 'rhysd/git-messenger.vim'        " inline git blame
Plug 'reedes/vim-wordy'               " grammar check
Plug 'sirver/ultisnips'               " snippets
Plug 'tommcdo/vim-lion'               " alignment motion
Plug 'tpope/vim-commentary'           " comment code
Plug 'tpope/vim-markdown'             " markdown
Plug 'tpope/vim-obsession'            " session control
Plug 'tpope/vim-surround'             " surround motion
Plug 'vimwiki/vimwiki'                " bees knees
call plug#end()

" Settings
let mapleader=","

" Colors
syntax on
if has( "termguicolors" )
    set termguicolors
endif
colorscheme OceanicNext

" Whitespace stuff
set expandtab
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
set hlsearch          " highlight search term
set showcmd           " show command
set laststatus=2      " statusline
set noshowmode        " hide mode, its in status

" Operation
set scrolloff=2       " scroll 2 lines top/bottom
set hidden            " allows to switch to/from unsaved buffers
set nobackup

set modeline          " use modeline override
set modelines=2       " check last two lines
set mouse=a           " enable mouse support

" move updown by visual (wrapped) lines
noremap j gj
noremap k gk

let g:python3_host_prog = '/usr/bin/python3'

" shhhh
set novisualbell
set nobackup
set noerrorbells
autocmd VimEnter * set vb t_vb=

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

    " Templates
    autocmd BufRead,BufNewFile *.{tpl,eco} set ft=html

    " Remember last location in file
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

    autocmd filetype crontab setlocal nobackup nowritebackup

    " Default wrap markdown
    autocmd BufRead,BufNewFile *.md :Wrap
 
augroup END

" Key Bindings

" :w!! to save with sudo
ca w!! w !sudo tee >/dev/null "%"

" Unhighlight Search using ,SPC
" vim-slash helps by unhighlighting on move
noremap <Leader><Space> :nohlsearch<CR>

" Toggle comments using vim-commentary
map <Leader>/ gcc

" Buffer Navigation
nnoremap <Leader>3 :b#<CR>    " previous buffer
nnoremap <Leader>n :bn<CR>    " next buffer
nnoremap Q :bd!<CR>           " close buffer
nnoremap <Leader>a :only<CR>  " only buffer

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

" Map F1 to ESC
noremap <F2> :set wrap!<CR>
inoremap <F2> :set wrap!<CR>

" toggle show whitespace
noremap <F3> :set list!<CR>

" Insert Date
:nnoremap <F4> "=strftime("%A, %Y-%m-%d %I:%M%P ")<CR>P
:inoremap <F4> <C-R>=strftime("%A, %Y-%m-%d %I:%M%P ")<CR>

" Toggle Spellcheck
:noremap <F5> :setlocal spell! spelllang=en_us<CR>

" Add semi colon at end of line
noremap <Leader>; g_a;<Esc>

" Add Spaces inside parentheses, WordPress Style
noremap <Leader>o ci(<space><space><Esc>hp

" Edit config file
nnoremap <Leader>re :edit $MYVIMRC<CR>
nnoremap <Leader>rs :source $MYVIMRC<CR>

" Run Hastie
noremap <Leader>h :terminal hastie<CR>

" :Wrap command
command! -nargs=* Wrap set wrap linebreak nolist

" Plugin Settings

" Lightline
let g:lightline = {
    \ 'colorscheme': 'oceanicnext',
    \ 'active' : {
    \   'left' : [ [ 'mode', 'paste' ],
    \       [ 'readonly', 'filename', 'modified', ] ],
    \   'right' : [ [ 'lineinfo' ],
    \               [ 'filetype' ],
    \               [ 'buffernum' ] ]
    \ },
    \ 'component': {
    \   'buffernum': '%n'
    \ },
    \ }

" Git Gutter
set updatetime=250
nmap ]c <Plug>GitGutterNextHunk
nmap [c <Plug>GitGutterPrevHunk

" Goyo
noremap <F8> :Goyo<CR>
let g:goyo_width = 70

" Ultisnips
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
let g:UltiSnipsUsePythonVersion = 3

" Vim Wiki
let g:vimwiki_list = [{'path': '~/Documents/Sync/vimwiki/', 'syntax': 'markdown'}]
command! Diary VimwikiDiaryIndex
augroup vimwikigroup
    autocmd!
    " set 6 space indent, aligns - [ ] task lists
    autocmd FileType vimwiki setlocal shiftwidth=6 tabstop=6 noexpandtab

    " automatically update links on read diary
    " autocmd BufRead,BufNewFile diary.wiki VimwikiDiaryGenerateLinks
augroup end

