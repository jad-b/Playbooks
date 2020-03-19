
" w0rp/ale
let b:ale_linters = ['golangci-lint']
let b:ale_fixers = ['gofmt', 'goimports']
let b:ale_go_gofmt_options = ['-s']
let b:ale_go_golangci_lint_options = '--enable-all --fast'
let b:ale_go_golangci_lint_package = 1

" ---------- vim-go ----------
let g:go_version_warning = 0
" Run :Lint to execute golint on the current file
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
" Run commands, such as go run with <leader>r for the current file or go build
" and go test for the current package with <leader>b and <leader>t. Display a
" beautiful annotated source code to see which functions are covered with <leader>c
au FileType go nmap <leader>gr <Plug>(go-run)
au FileType go nmap <leader>gb <Plug>(go-build)
au FileType go nmap <leader>gt <Plug>(go-test)
au FileType go nmap <leader>gc <Plug>(go-coverage)
au FileType go nmap <leader>gv <Plug>(go-vet)
" Open the relevant Godoc for the word under the cursor with <leader>gd
" or open it vertically with <leader>gv
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gdv <Plug>(go-doc-vertical)
" Show a list of interfaces which is implemented by the type under your cursor with <leader>s
au FileType go nmap <Leader>gs <Plug>(go-implements)
" Show type info for the word under your cursor with <leader>i (useful if you have disabled auto showing type info via g:go_auto_type_info)
au FileType go nmap <Leader>gi <Plug>(go-info)
" Rename the identifier under the cursor to a new name
au FileType go nmap <Leader>e <Plug>(go-rename)
" Enable goimports to automatically insert import paths instead of gofmt:

nnoremap gb :GoDocBrowser<CR>
