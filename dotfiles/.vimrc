set rtp+=$GOROOT/misc/vim
filetype plugin indent on
syntax on

set tabstop=4
set shiftwidth=4
set expandtab
set paste

"cursor line
set cursorline

set number

match Todo /\s\+$/

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

"let g:indent_guides_enable_on_vim_startup=1
"let g:indent_guides_start_level = 2
"let g:indent_guides_guide_size = 1

set t_Co=256

"pathogen management
execute pathogen#infect()

syntax enable
set background=dark
colorscheme molokai
let g:molokai_original = 1

let g:go_disable_autoinstall = 0
let g:go_fmt_command = "goimports"

nmap <C-S-b> :GoBuild<CR>

" VIM GO FUNCTIONS
" Highlight
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" Ctags
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

nmap <F8> :TagbarToggle<CR>

" tabbing
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>
