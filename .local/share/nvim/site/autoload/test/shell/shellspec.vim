if !exists('g:test#shell#shellspec#file_pattern')
  let g:test#shell#shellspec#file_pattern = '_spec\.sh$'
endif

if !exists('g:test#shell#shellspec#patterns')
  let g:test#shell#shellspec#patterns = {
        \ 'test': [
        \ '\v^\s*\It %("|'')(.*)%("|'')'
        \ ],
        \ 'namespace': []
        \ }
endif

" Returns true if the given file belongs to your test runner
function! test#shell#shellspec#test_file(file) abort
  return a:file =~# g:test#shell#shellspec#file_pattern
endfunction

" Returns test runner's arguments which will run the current file and/or line
function! test#shell#shellspec#build_position(type, position) abort
  return []
endfunction

" Returns processed args (if you need to do any processing)
function! test#shell#shellspec#build_args(args) abort
  return a:args
endfunction

" Returns the executable of your test runner
function! test#shell#shellspec#executable() abort
  return 'shellspec'
endfunction
