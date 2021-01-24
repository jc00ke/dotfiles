au FileType elixir nnoremap io o\|> IO.inspect(printable_limit: :infinity)<Esc>
au FileType elixir nnoremap IO o\|> IO.inspect(label: "<C-r>=line(".")<C-M>: ", printable_limit: :infinity)<Esc>F"i
au FileType elixir nnoremap ii a \|> IO.inspect(printable_limit: :infinity)<Esc>i
au FileType elixir nnoremap II a \|> IO.inspect(label: "<C-r>=line(".")<C-M>: ", printable_limit: :infinity)<Esc>F"i
au FileType elixir nnoremap <leader>r orequire IEx; IEx.pry<esc>
