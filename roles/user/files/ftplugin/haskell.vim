" Tab specific option
set tabstop=8                   "A tab is 8 spaces
set expandtab                   "Always uses spaces instead of tabs
set softtabstop=4               "Insert 4 spaces when tab is pressed
set shiftwidth=4                "An indent is 4 spaces
set shiftround                  "Round indent to nearest shiftwidth multiple

" neovimhaskell/haskell-vim
" Align 'then' two spaces after 'if'
let g:haskell_indent_if = 2
" Indent 'where' block two spaces under previous body
let g:haskell_indent_before_where = 2
" Allow a second case indent style (see haskell-vim README)
let g:haskell_indent_case_alternative = 1
" Only nest under 'let' if there's an equals sign
let g:haskell_indent_let_no_in = 0

" w0rp/ale
let b:ale_linters = ['hlint', 'hdevtools']
let b:ale_fixers = ['hlint', 'hindent']

" vim-hindent
" let b:hindent_on_save = 1

" haskell-vim
let b:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let b:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let b:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let b:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let b:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let b:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let b:haskell_backpack = 1                " to enable highlighting of backpack keywords

" vim-hdevtools
" locally install stack per project
let b:hdevtools_stack = 1
" defer GHC type errors to runtime
let b:hdevtools_options = '-g-fdefer-type-errors'
let b:ale_haskell_hdevtools_options = '-g -Wall --socket ./'
augroup hdevtoolsMaps
  au!
  au FileType haskell nnoremap <buffer> <leader>ht :HdevtoolsType<CR>
  au FileType haskell nnoremap <buffer> <silent> <leader>hi :HdevtoolsInfo<CR>
  au FileType haskell nnoremap <buffer> <silent> <leader>hc :HdevtoolsClear<CR>
augroup END

" parsonsmatt/intero-neovim
let b:intero_type_on_hover = 1
let b:intero_use_neomake = 1
augroup interoMaps
  au!

  au FileType haskell nnoremap <silent> <leader>io :InteroOpen<CR>
  au FileType haskell nnoremap <silent> <leader>iov :InteroOpen<CR><C-W>H
  au FileType haskell nnoremap <silent> <leader>ih :InteroHide<CR>
  au FileType haskell nnoremap <silent> <leader>is :InteroStart<CR>
  au FileType haskell nnoremap <silent> <leader>ik :InteroKill<CR>

  au FileType haskell nnoremap <silent> <leader>wr :w \| :InteroReload<CR>
  au FileType haskell nnoremap <silent> <leader>il :InteroLoadCurrentModule<CR>
  au FileType haskell nnoremap <silent> <leader>if :InteroLoadCurrentFile<CR>

  au FileType haskell map <leader>t <Plug>InteroGenericType
  au FileType haskell map <leader>T <Plug>InteroType
  au FileType haskell nnoremap <silent> <leader>it :InteroTypeInsert<CR>

  au FileType haskell nnoremap <silent> <leader>jd :InteroGoToDef<CR>
  au FileType haskell nnoremap <silent> <leader>iu :InteroUses<CR>
  au FileType haskell nnoremap <leader>ist :InteroSetTargets<SPACE>

  " Automatically reload on save
  au BufWritePost *.hs InteroReload
augroup END
