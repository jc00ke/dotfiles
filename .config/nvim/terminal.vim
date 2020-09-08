" run sh since neovim doesn't fully support fish yet
if &shell =~# 'fish$'
  set shell=sh
endif

" allow terminal buffer size to be very large
let g:terminal_scrollback_buffer_size = 100000

" map esc to exit to normal mode in terminal too
tnoremap <Esc><Esc> <C-\><C-n>

" Jump and Create splits easily
nmap <Leader>fs :Term<CR>
nmap <Leader>fv :VTerm<CR>
nmap <Leader>ff :TTerm<CR>
nmap <Leader>fp :TTerm<CR> postgres<CR>
let g:split_term_default_shell = "fish"
