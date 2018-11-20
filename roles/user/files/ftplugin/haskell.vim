" Tab specific option
set tabstop=8                   "A tab is 8 spaces
set expandtab                   "Always uses spaces instead of tabs
set softtabstop=4               "Insert 4 spaces when tab is pressed
set shiftwidth=4                "An indent is 4 spaces
set shiftround                  "Round indent to nearest shiftwidth multiple

" ALE
let b:ale_linters = ['hlint', 'hdevtools']
let b:ale_fixers = ['hlint', 'hindent']

" vim-hindent
let b:hindent_on_save = 1

" haskell-vim
let b:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let b:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let b:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let b:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let b:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let b:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let b:haskell_backpack = 1                " to enable highlighting of backpack keywords

" vim-hdevtools
let b:hdevtools_stack = 1
