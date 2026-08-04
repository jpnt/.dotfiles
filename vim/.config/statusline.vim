set laststatus=2

set statusline=
set statusline+=%<%f
set statusline+=\ %m%r
set statusline+=%=

set statusline+=%{&filetype}
set statusline+=\ %{empty(&fileencoding)?&encoding:&fileencoding}
set statusline+=\ %{&fileformat}
set statusline+=\ %l:%c
set statusline+=\ %p%%
