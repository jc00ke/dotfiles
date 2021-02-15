let g:clap_theme = 'solarized_light'
let g:clap_layout = { 'relative': 'editor' }
nnoremap <C-p> :Clap files<CR>
nnoremap <C-_> :Clap blines<CR>
nnoremap <Leader>a :Clap grep<CR>
nnoremap <Leader>A :Clap grep ++query=<cword><CR>
