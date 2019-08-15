autocmd BufRead,BufNewFile *.tf setlocal filetype=terraform sw=2 ts=2 expandtab tw=0

" ALE
let b:ale_fix_on_save = 1
let b:ale_fixers = [ 'terraform' ]
