set tabstop=4
set softtabstop=4
set shiftwidth=4

setlocal path+=/usr/include include&
setlocal commentstring=//\ %s

" LSP settings for clangd
au User lsp_setup call lsp#register_server({
  \ 'name': 'clangd',
  \ 'cmd': {server_info->['clangd']},
  \ 'allowlist': ['c', 'cpp'],
  \ 'blocklist': [],
  \ })

