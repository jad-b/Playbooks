" Tab specific option
set tabstop=2                   "A tab is 4 spaces
set expandtab                   "Always uses spaces instead of tabs
set softtabstop=2               "Insert 2 spaces when tab is pressed
set shiftwidth=2                "An indent is 2 spaces
set shiftround                  "Round indent to nearest shiftwidth multiple

set autoindent
set nocindent
set smartindent

" w0rp/ale
let b:ale_haskell_hlint_executable = 'stack'
let b:ale_haskell_stylish_haskell_executable = 'stack'
let b:ale_linters = ['hlint'] ", 'hdevtools']
let b:ale_fixers = ['hlint', 'stylish-haskell']

" neovimhaskell/haskell-vim
let b:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let b:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let b:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let b:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let b:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let b:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let b:haskell_backpack = 1                " to enable highlighting of backpack keywords
let g:haskell_indent_disable = 1

" hspec/hspec
highlight link hspecDescribe Type
highlight link hspecIt Identifier
highlight link hspecDescription Comment

" vim-hindent
" let b:hindent_on_save = 0
" let g:hindent_indent_size = 2
" au FileType haskell nnoremap <silent> <leader>ph :Hindent<CR>

" stylish-haskell
let g:stylishask_on_save = 1
au FileType haskell nnoremap <silent> <leader>ps :Stylishask<CR>

" vim-hdevtools
" locally install stack per project
" let b:hdevtools_stack = 1
" " defer GHC type errors to runtime
" let b:hdevtools_options = '-g-fdefer-type-errors'
" let b:ale_haskell_hdevtools_options = '-g -Wall --socket ./'
" augroup hdevtoolsMaps
"   au!
"   au FileType haskell nnoremap <buffer> <leader>ht :HdevtoolsType<CR>
"   au FileType haskell nnoremap <buffer> <silent> <leader>hi :HdevtoolsInfo<CR>
"   au FileType haskell nnoremap <buffer> <silent> <leader>hc :HdevtoolsClear<CR>
" augroup END
"
" " parsonsmatt/intero-neovim
" let b:intero_start_immediately = 0
" let b:intero_type_on_hover = 1
" let b:intero_use_neomake = 0
" augroup interoMaps
"   au!
"
"   au FileType haskell nnoremap <silent> <leader>io :InteroOpen<CR>
"   au FileType haskell nnoremap <silent> <leader>iov :InteroOpen<CR><C-W>H
"   au FileType haskell nnoremap <silent> <leader>ih :InteroHide<CR>
"   au FileType haskell nnoremap <silent> <leader>is :InteroStart<CR>
"   au FileType haskell nnoremap <silent> <leader>ik :InteroKill<CR>
"
"   au FileType haskell nnoremap <silent> <leader>wr :w \| :InteroReload<CR>
"   au FileType haskell nnoremap <silent> <leader>il :InteroLoadCurrentModule<CR>
"   au FileType haskell nnoremap <silent> <leader>if :InteroLoadCurrentFile<CR>
"
"   au FileType haskell map <leader>t <Plug>InteroGenericType
"   au FileType haskell map <leader>T <Plug>InteroType
"   au FileType haskell nnoremap <silent> <leader>it :InteroTypeInsert<CR>
"
"   au FileType haskell nnoremap <silent> <leader>jd :InteroGoToDef<CR>
"   au FileType haskell nnoremap <silent> <leader>iu :InteroUses<CR>
"   au FileType haskell nnoremap <leader>ist :InteroSetTargets<SPACE>
"
"   " Automatically reload on save
"   " au BufWritePost *.hs InteroReload
" augroup END
