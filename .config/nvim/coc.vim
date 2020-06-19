"let g:coc_global_extensions = ['coc_prettier', 'coc_json']
" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

call coc#config('elixir', {
      \ "pathToElixirLS": "~/src/elixir-ls/release/language_server.sh"
      \})

call coc#config('suggest', {
      \ "timeout": 1000
      \})

call coc#config('codeLens', {
      \ "enable": 'true'
      \})

call coc#config('coc.preferences', {
  \ "timeout": 1000,
  \ "formatOnSaveFiletypes": [
    \ "css",
    \ "Markdown",
    \ "JavaScript",
    \ "json",
    \ "elm"
  \],
  \ 'colorSupport': 'true'
  \})
call coc#config('languageserver', {
  \  "elmLS": {
  \    "trace.server": "verbose",
  \    "command": "elm-language-server",
  \    "args": ["--stdio"],
  \    "filetypes": ["elm"],
  \    "rootPatterns": ["elm.json"],
  \    "initializationOptions": {
  \      "elmPath": "elm",
  \      "elmFormatPath": "elm-format",
  \      "elmTestPath": "elm-test",
  \      "elmAnalyseTrigger": "change"
  \    }
  \  },
  \  "terraform": {
  \    "command": "terraform-ls",
  \    "args": ["serve"],
  \    "filetypes": ["terraform", "tf"],
  \    "initializationOptions": {},
  \    "settings": {}
  \  }
  \})

call coc#config('diagnostic-languageserver.filetypes', {
  \  "markdown": [ "write-good", "markdownlint" ],
  \  "sh": "shellcheck -x",
  \  "elixir": ["mix_credo", "mix_credo_compile"],
  \  "eelixir": ["mix_credo", "mix_credo_compile"]
  \})
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Confirm completion
"inoremap <expr><cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gR <Plug>(coc-rename)
" Fix autofix problem of current line
nmap <silent> gx <Plug>(coc-fix-current)
" Remap for do codeAction of current line
nmap <silent> ga <Plug>(coc-codeaction)
" Remap for do codeLensAction of current line
nmap <silent> gl <Plug>(coc-codelens-action)
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

autocmd CursorHold * silent call CocActionAsync('highlight')

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:coc_float_scroll(forward) abort
  let float = coc#util#get_float()
  if !float | return '' | endif
  let buf = nvim_win_get_buf(float)
  let buf_height = nvim_buf_line_count(buf)
  let win_height = nvim_win_get_height(float)
  if buf_height < win_height | return '' | endif
  let pos = nvim_win_get_cursor(float)
  if a:forward
    if pos[0] == 1
      let pos[0] += 3 * win_height / 4
    elseif pos[0] + win_height / 2 + 1 < buf_height
      let pos[0] += win_height / 2 + 1
    endif
    let pos[0] = pos[0] < buf_height ? pos[0] : buf_height
  else
    if pos[0] == buf_height
      let pos[0] -= 3 * win_height / 4
    elseif pos[0] - win_height / 2 + 1  > 1
      let pos[0] -= win_height / 2 + 1
    endif
    let pos[0] = pos[0] > 1 ? pos[0] : 1
  endif
  call nvim_win_set_cursor(float, pos)
  return ''
endfunction

nnoremap <silent><expr> <down> coc#util#has_float() ? coc#util#float_scroll(1) : "\<down>"
nnoremap <silent><expr> <up> coc#util#has_float() ? coc#util#float_scroll(0) : "\<up>"
inoremap <silent><expr> <down> coc#util#has_float() ? <SID>coc_float_scroll(1) : "\<down>"
inoremap <silent><expr> <up> coc#util#has_float() ? <SID>coc_float_scroll(0) : "\<up>"
vnoremap <silent><expr> <down> coc#util#has_float() ? <SID>coc_float_scroll(1) : "\<down>"
vnoremap <silent><expr> <up> coc#util#has_float() ? <SID>coc_float_scroll(0) : "\<up>"

command! -nargs=0 Prettier :CocCommand prettier.formatFile
