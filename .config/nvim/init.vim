set nocompatible
syntax on

set relativenumber
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
set nohlsearch
set smartcase
set noshowmode
set scrolloff=8

set cmdheight=2
set updatetime=50
set shortmess+=c
set cursorline
set colorcolumn=120
set modelines=0

filetype off
call plug#begin()
Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'ycm-core/YouCompleteMe'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf.vim'
call plug#end()

filetype plugin indent on

let g:ycm_clangd_binary_path = "/usr/bin/clangd"

colorscheme nord
let g:nord_cursor_line_number_background = 1
let g:nord_uniform_diff_background = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_theme='nord'

let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.dirty='⚡'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

let g:netrw_banner =  0
let g:netrw_browse_split=2
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_winsize = 25


" FUNCTION DEFINITIONS
" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

function! ToggleVExplore()
    if exists("t:expl_buf_num")
        let expl_win_num = bufwinnr(t:expl_buf_num)
        let cur_win_num = winnr()

        if expl_win_num !=-1
            while expl_win_num != cur_win_num
                exec "wincmd w"
                let cur_win_num = winnr()
            endwhile
            close
        endif
        unlet t:expl_buf_num
    else
        Lexplore
        let t:expl_buf_num = bufnr("%")
    endif
endfunction


map <F2> <C-O>:set invpaste paste?<CR>
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" Fixes common backspace problems
set backspace=indent,eol,start

" Map the <Space> key to toggle a selected fold opened/closed.
" nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
" vnoremap <Space> zf

" Easy saving
inoremap <C-u> <ESC>:w<CR>
nnoremap <C-u> :w<CR>

" Editing vimrc
let mapleader = " "

" Switch between windows
nnoremap <leader>j :wincmd j <CR>
nnoremap <leader>k :wincmd k <CR>
nnoremap <leader>l :wincmd l <CR>
nnoremap <leader>h :wincmd h <CR>

nmap <silent> <leader>d  :call ToggleVExplore()<CR>
nmap <silent> <leader>u  :call UndoTreeShow<CR>
nmap <silent> <leader>gd :YcmCompleter GoTo<CR>
nmap <silent> <leader>gi :YcmCompleter GoToImplementation<CR>
nmap <silent> <leader>gr :YcmCompleter GoToReferences<CR>

nmap <silent> <leader>fs :YcmCompleter GotoSymbols<CR>
nmap <silent> <leader>fi :YcmCompleter FixIt<CR>
nmap          <leader>rr :YcmCompleter RefactorName
nmap <silent> <leader>t  :YcmCompleter GetType<CR>
nmap <silent> <leader>doc :YcmCompleter GetDoc<CR>
nmap <silent> <leader>rf :YcmCompleter Format<CR>

nmap <silent> <leader>f :Files<CR>
nmap <silent> <C-P> :GFiles<CR>

"FuGITive
nmap <leader>gs :G<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gds :Gdiffsplit<CR>


function! TrimWhitespace()
    let l:winview = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:winview)
endfunction

autocmd BufWritePre * :call TrimWhitespace()

