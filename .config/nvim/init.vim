set nocompatible

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
"set undodir=~/.config/nvim/undodir
set undofile
set smartcase
set noshowmode

set cmdheight=2
set updatetime=50
set shortmess+=c
set cursorline
set colorcolumn=120
set modelines=0
set completeopt=longest,menuone

filetype off
call plug#begin()
Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'jiangmiao/auto-pairs'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

call plug#end()

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

au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'allowlist': ['c', 'cpp'],
        \ })


let g:lsp_signs_error = {'text': '✖️'}
let g:lsp_signs_warning = {'text': '⚠️'}
let g:lsp_signs_hint = {'text': '〰️'} 
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1 
let g:lsp_textprop_enabled = 0
let g:lsp_virtual_text_enabled = 0



" FUNCTION DEFINITIONS
" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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

" Editing vimrc
let mapleader = " "

" Switch between windows
nnoremap <silent> <leader>j :wincmd j <CR>
nnoremap <silent> <leader>k :wincmd k <CR>
nnoremap <silent> <leader>l :wincmd l <CR>
nnoremap <silent> <leader>h :wincmd h <CR>

nmap <silent> <leader>d  :call ToggleVExplore()<CR>
nmap <silent> <leader>u  :call UndoTreeShow<CR>

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> <leader>fi <plug>(lsp-code-action)
    vmap <buffer> <leader>rf <plug>(lsp-document-range-format)
    nmap <buffer> <leader>rf <plag>(lsp-document-format)
    nmap <buffer> <leader>gd <plug>(lsp-definition)
    nmap <buffer> <leader>gr <plug>(lsp-references)
    nmap <buffer> <leader>gi <plug>(lsp-implementation)
    nmap <buffer> <leader>gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rr <plug>(lsp-rename)
    nmap <buffer> <leader>ek <plug>(lsp-previous-diagnostic)
    nmap <buffer> <leader>ej <plug>(lsp-next-diagnostic)
    nmap <buffer> <leader>h  <plug>(lsp-hover)
    nmap <buffer> <leader>fa <plug>(lsp-workspace-symbol)    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

nmap <silent> <leader>f :Files<CR>
nmap <silent> <C-P> :GFiles<CR>

"FuGITive
nmap <leader>gs :G<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gds :Gdiffsplit<CR>

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

function! TrimWhitespace()
    let l:winview = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:winview)
endfunction

autocmd BufWritePre * :call TrimWhitespace()

