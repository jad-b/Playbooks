autocmd BufRead,BufNewFile *.elm set filetype=elm autoindent tabstop=2 shiftwidth=2 expandtab

" elm-vim
let g:elm_format_autosave = 1

" ALE
let b:ale_fix_on_save = 1
let b:ale_fixers = [ 'elm-format' ]
