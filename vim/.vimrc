set nu
set incsearch
set cursorline
set tabstop=4 softtabstop=4
set shiftwidth=4
set nocompatible
set path+=**
set wildmenu

syntax enable
filetype plugin indent on

command! MakeTags !ctags -R .

let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\s\s\)\zs\.\S\+'

nnoremap ,html :-1read $HOME/.vim/.skeleton.html<CR>3jwf>a

set makeprg=bundle\ exec\ rspec\ -f\ QuickfixFormatter

call plug#begin()
Plug 'jiangmiao/auto-pairs'
call plug#end()
