lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    prompt_position = "top",
    sorting_strategy = "ascending"
  }
}
EOF
" Find files using Telescope command-line sugar.
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-_> <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <Leader>a <cmd>Telescope live_grep<cr>
nnoremap <Leader>A <cmd>Telescope grep_string<cr>

" Using lua functions
nnoremap <leader>tff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>tfg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>tfb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>tfh <cmd>lua require('telescope.builtin').help_tags()<cr>
