" Sane settings
set nu rnu
set incsearch
set cursorline
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set nocompatible
set mouse=a

" Fuzzy file finding using :find
set path+=**
set wildmenu

" Syntax highlighting
syntax enable
filetype plugin indent on

" Generate Ctags using :MakeTags
command! MakeTags !ctags -R .

" Netrw customization
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\s\s\)\zs\.\S\+'

" Snippets
nnoremap ,html :-1read $HOME/.vim/.skeleton.html<CR>3jwf>a

" Build integration
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" Open recent files pressing r-Ctrl-f
nmap r<C-f> :bro ol<CR>

" Open Tagbar pressing F8
nmap <F8> :TagbarToggle<CR>

" Plugins
call plug#begin()
Plug 'jiangmiao/auto-pairs'
Plug 'vim-test/vim-test'
Plug 'preservim/tagbar'
call plug#end()
