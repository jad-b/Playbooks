" ALE - Python
let g:ale_python_pylint_executable = 'python3'   " or 'python' for Python 2
let g:ale_python_pylint_options = '-rcfile ~/.pylintrc'
let g:ale_python_flake8_executable = 'python3'
let g:ale_python_flake8_options = '-m flake8'

" Python-mode
" let g:pymode_doc = 0
" Disable python-mode's syntax checks in favor of Syntastic's
" let g:pymode_lint_write = 0
