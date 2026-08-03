vim9script

# for more information: :h ins-autocompletion

set autocomplete
set complete=.^5,w^5,b^5,u^5
set completeopt=popup

inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
