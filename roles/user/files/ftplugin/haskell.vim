set autoindent
set expandtab                   "Always uses spaces instead of tabs
set nocindent
set shiftround                  "Round indent to nearest shiftwidth multiple
set shiftwidth=2                "An indent is 2 spaces
set smartindent
set softtabstop=2               "Insert 2 spaces when tab is pressed
set tabstop=2                   "A tab is 4 spaces

" w0rp/ale
let b:ale_haskell_hlint_executable = 'stack'
let b:ale_haskell_stylish_haskell_executable = 'stack'
let b:ale_linters = ['hlint']
let b:ale_fixers = []

"alx741/vim-stylishask
let b:stylishask_on_save = 1
nnoremap <leader>l :Stylishask<CR>

" hspec/hspec
highlight link hspecDescribe Type
highlight link hspecIt Identifier
highlight link hspecDescription Comment

" neovimhaskell/haskell-vim
let b:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let b:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let b:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let b:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let b:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let b:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let b:haskell_backpack = 1                " to enable highlighting of backpack keywords
let g:haskell_indent_disable = 1
