set autoindent
set expandtab
set shiftwidth=4
set smarttab
set softtabstop=4
set tabstop=4
set textwidth=79

" w0rp/ale
let b:ale_fix_on_save = 1
let b:ale_linters = ['rls']
let b:ale_fixers = ['rustfmt']

let b:ale_rust_rustfmt_options = '--edition 2018'
let b:ale_rust_rls_toolchain = 'nightly'
