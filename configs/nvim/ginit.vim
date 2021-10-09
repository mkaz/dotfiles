" gvimrc - optimized for ctrl-alt-vim
" From: https://github.com/mkaz/ctrl-alt-vim
"
" use vim-plug to manage plugins
" See: https://github.com/junegunn/vim-plug

call plug#begin('~/.config/plugged')
Plug 'junegunn/goyo.vim'              " writing
Plug 'junegunn/vim-slash'             " search highlighting
Plug 'mhartington/oceanic-next'       " colors
Plug 'reedes/vim-wordy'               " grammar check
Plug 'sirver/ultisnips'               " snippets
Plug 'tommcdo/vim-lion'               " alignment motion
Plug 'tpope/vim-commentary'           " comment code
Plug 'tpope/vim-markdown'             " markdown
Plug 'tpope/vim-obsession'            " session control
Plug 'tpope/vim-sensible'             " default settings
Plug 'tpope/vim-surround'             " surround motion
call plug#end()

" Settings
let mapleader=","
colorscheme OceanicNext

set expandtab
set tabstop=4
set softtabstop=4
set wrap!
set linebreak
set listchars=tab:▸\ ,eol:¬     " hidden characters
set number                      " show line numbers
set hlsearch                    " highlight search term
set showcmd                     " show command
set noshowmode                  " hide mode, its in status
set hidden                      " allows to switch to/from unsaved buffers
set nobackup
set mouse=a                     " enable mouse support
set novisualbell
set noerrorbells
set ignorecase
set smartcase
set undolevels=1000

" Gooey bits
set guifont=Hack:h15
set guioptions-=T  "toolbar
set guioptions-=r  "scrollbar

"" Key Bindings

" move updown by visual (wrapped) lines
noremap j gj
noremap k gk

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

" Use K to 'krack' a line, opposite of J
nnoremap K i<CR><Esc>k$

" Add Spaces inside parentheses, WordPress Style
noremap <Leader>o ci(<space><space><Esc>hp

" :Wrap command
command! -nargs=* Wrap set wrap linebreak nolist

" Plugin Settings
"
" Ultisnips
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
let g:UltiSnipsUsePythonVersion = 3

" Goyo
noremap <F8> :Goyo<CR>
let g:goyo_width = 70
function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()


function! WordCount()
    let currentmode = mode()
    if !exists("g:lastmode_wc")
        let g:lastmode_wc = currentmode
    endif
    " if we modify file, open a new buffer, be in visual ever, or switch modes
    " since last run, we recompute.
    if &modified || !exists("b:wordcount") || currentmode =~? '\c.*v' || currentmode != g:lastmode_wc
        let g:lastmode_wc = currentmode
        let l:old_position = getpos('.')
        let l:old_status = v:statusmsg
        execute "silent normal g\<c-g>"
        if v:statusmsg == "--No lines in buffer--"
            return 'Empty'
        else
            let s:split_wc = split(v:statusmsg)
            if index(s:split_wc, "Selected") < 0
                let b:wordcount = str2nr(s:split_wc[11])
            else
                let b:wordcount = str2nr(s:split_wc[5])
            endif
            let v:statusmsg = l:old_status
        endif
        call setpos('.', l:old_position)
        return b:wordcount . ' words'
    else
        return b:wordcount . ' words'
    endif
endfunction

" start in insert mode
startinsert
