set nocompatible              " be iMproved, required
filetype off                  " required
set t_Co=256

" set the runtime path to include Vundle and initialize
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" ~~~~~~~~~~~~~~ Vim Itself ~~~~~~~~~~~~~~
" Colorscheme
Plugin 'altercation/vim-colors-solarized'
" Netrw improvements
Plugin 'tpope/vim-vinegar'
" gpg inside vim
Plugin 'jamessan/vim-gnupg'
" Commonly-used mappings
Plugin 'tpope/vim-unimpaired'
" Track the engine.
Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
" Allows toggling between relative and absolute line numbers with C-n
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
" Improve the status bar
Plugin 'bling/vim-airline'
" List open buffers
Plugin 'bling/vim-bufferline'
" Tagbar
Plugin 'majutsushi/tagbar'
" Fuzzy search for files
Plugin 'kien/ctrlp.vim'
" Commands for working with surrounding text objects
Plugin 'tpope/vim-surround'
" Quick (un)comment commands
Plugin 'scrooloose/nerdcommenter'
" Quickly align text
Plugin 'godlygeek/tabular'
" Smarter code folding
Plugin 'tmhedberg/SimpylFold'
" Display tmux status bar
Plugin 'edkolev/tmuxline.vim'

" ~~~~~~~~~~~~~~ Language support ~~~~~~~~~~~~~~
" Syntastic
Plugin 'scrooloose/syntastic'
Plugin 'fatih/vim-go' " Go support
Plugin 'vim-scripts/nginx.vim' " Nginx conf highlighting
Plugin 'chase/vim-ansible-yaml'
Plugin 'tell-k/vim-autopep8' " Python - automatic pep8 fixes
Plugin 'vim-scripts/indentpython.vim' " Python PEP8 Indenting
Plugin 'hashivim/vim-hashicorp-tools' " HCL format
Plugin 'JuliaEditorSupport/julia-vim' " Julia
Plugin 'plasticboy/vim-markdown' " Markdown
Plugin 'derekwyatt/vim-scala' " Scala
"Plugin 'klen/python-mode' " Too much!

" ~~~~~~~~~~~~~~ Front-end Development ~~~~~~~~~~~~~~
" Close HTML/XML tags with ctrl-_
Plugin 'vim-scripts/closetag.vim'
Plugin 'hail2u/vim-css3-syntax'
" JavaScript Syntax
Plugin 'pangloss/vim-javascript'
" TypeScript
Plugin 'leafgarland/typescript-vim'


" All of your Plugins must be added before the following line
call vundle#end()            " required


" ------------------------------------------------------------------------------
"  Plugin Configuration
" ------------------------------------------------------------------------------
let g:ansible_options = {'ignore_blank_lines': 0}

" vim-airline
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" UltiSnips setting
" mae vim recognizing snippets dir
set runtimepath+=~/.vim/my-snippets/
" use different snippets dir
let g:UltiSnipsSnippetsDir='~/.vim/my-snippets/'
let g:UltiSnipsSnippetDirectories=["my-snippets"]
" use vertical split to edit snippets
let g:UltiSnipsEditSplit='vertical'
" trigger snippet with Ctrl-l
" let g:UltiSnipsExpandTrigger='<C-l>'
" go to next snippet with Ctrl-j
let g:UltiSnipsJumpForwardTrigger='<M-j>'
" go to previous snippet with Ctrl-k
let g:UltiSnipsJumpBackwardTrigger='<M-k>'
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:netrw_liststyle=3
let g:netrw_winsize=30

" Show docstrings for folded code
" let g:SimpylFold_docstring_preview=1

" ---------- tag-bar ----------
nmap <F8> :TagbarToggle<CR>

" ---------- vim-go ----------
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
let g:go_fmt_command = "goimports"
let g:syntastic_javascript_checkers = ['jshint']
" Comptability fixes for vim-go and Syntastic
let g:syntastic_go_checkers = ['gometalinter']
let g:syntastic_aggregate_errors = 1 " Run all checkers
let g:syntastic_go_gometalinter_args = "--fast --disable=gas --disable=dupl --disable=gotype --disable=gocyclo"
" let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:go_list_type = "quickfix"
" turn highlighting on
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_fail_silently = 1
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

" Python-mode
" let g:pymode_doc = 0
" Disable python-mode's syntax checks in favor of Syntastic's
" let g:pymode_lint_write = 0
"
" ---------- vim-markdown ----------
let g:vim_markdown_math = 1
let g:vim_markdown_toml_frontmatter = 1
" Auto-indent lists by 2 spaces
let g:vim_markdown_new_list_item_indent = 2

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors = 1
" Point Python interpreter to currently the Pyenv python
" let g:syntastic_python_python_exec = '/home/jdb/.pyenv/shims/python'
let g:syntastic_python_python_exec = '/usr/bin/python3'
let g:syntastic_python_checkers = ['flake8', 'python', 'pylint']
let g:syntastic_python_flake8_exec = 'python3'
let g:syntastic_python_flake8_args = ['-m', 'flake8']

let g:syntastic_eruby_ruby_quiet_messages =
    \ {'regex': 'possibly useless use of a variable in void context'}

" ------------------------------------------------------------------------------
filetype plugin indent on
" filetype indent on
syntax on
set omnifunc=syntaxcomplete#Complete

" Solarized
syntax enable
set background=dark
colorscheme solarized

" Mouse
" set mouse=a

" Files and buffers
" Hide instead of closing buffers
set hidden

" Prevent Vim from backing up your files
set nobackup
set noswapfile

" Whitespacing
set backspace=indent,eol,start
" show matching parentheses
set showmatch

" Trying to avoid 'Press ENTER...' prompts
set cmdheight=2

" ----------------------------------------
" 2) moving around, searching and patterns
" ----------------------------------------
" Uppercase letters triggers case sensitivity
set smartcase
" Normal mode
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==

" Insert mode
inoremap <C-j> <ESC>:m .+1<CR>==gi
inoremap <C-k> <ESC>:m .-2<CR>==gi

" Visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv"

" ----------------------------------------
" 6) multiple windows
" ----------------------------------------
set wmh=0   " Minimum window is zero, so minimized files are less obtrusive

" Move between windows with Ctrl + j/k
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitright
set splitbelow

" Delete buffer without closing split
nmap ,d :b#<bar>bd#<CR>

" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar (also 'za')
nnoremap <space> za

" -----------------------------------------------------------------------------
" 7) multiple tab pages
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" 14) tabs and indenting
" -----------------------------------------------------------------------------
set autoindent
set expandtab
set shiftwidth=4
set smarttab
set softtabstop=4
set tabstop=4
set textwidth=79

" Searching
set ignorecase
set smartcase
set hlsearch
set incsearch

" History
set undolevels=1000
"set title

" Sounds
set visualbell
set noerrorbells
set showmode

" -----------------------------------------------------------------------------
" 18) reading and writing files
" -----------------------------------------------------------------------------
"  Work around of vim-vinegar causing netrw buffers to never die
autocmd FileType netrw setl bufhidden=wipe
"  Change current directory to currently open file
autocmd BufEnter * silent! lcd %:p:h

" Remove trailing whitespace
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

 autocmd Filetype yaml,html,ruby,kivy,tmpl,css,hbs,scss setlocal autoindent tabstop=2 shiftwidth=2 expandtab
autocmd BufRead,BufNewFile *.ts set filetype=typescript
autocmd BufRead,BufNewFile *.conf set filetype=conf
autocmd BufRead,BufNewFile *.scss set filetype=css
autocmd BufRead,BufNewFile *.deploy set filetype=yaml
autocmd BufRead,BufNewFile *.yml set filetype=yaml
autocmd BufRead,BufNewFile Vagrantfile* set filetype=ruby
autocmd BufRead,BufNewFile *.md set filetype=markdown textwidth=80
autocmd BufRead,BufNewFile Dockerfile.* set filetype=dockerfile
autocmd BufNewFile,BufRead *.groovy  set filetype=groovy

" Turn on spell-checking in text files
" au BufRead,BufNewFile *.md,*.txt,*.rst setlocal spell spelllang=en_us
"
" Auto-recognize groovy scripts by the shebang
if did_filetype() " Already recognized filetype
	finish
endif
if getline(1) =~ '^#!.*[/\\]groovy\>' " #!/path/things/groovy
	setf groovy
endif

" --------------------------------------
" Plugins
" --------------------------------------
" Taken f/ beautiful_vim cheat sheet;
" Should make `%%` refer to current file's directory
" cnoremap %% <C-R>=expand(‘%:h’).’/’<CR>

" Relative line numbers
function! NumberToggle()
    if(&relativenumber == 1)
        set number
    else
        set relativenumber
    endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

"toggles whether or not the current window is automatically zoomed
function! ToggleMaxWins()
  if exists('g:windowMax')
    au! maxCurrWin
    wincmd =
    unlet g:windowMax
  else
    augroup maxCurrWin
        " au BufEnter * wincmd _ | wincmd |
        "
        " only max it vertically
        au! WinEnter * wincmd _
    augroup END
    do maxCurrWin WinEnter
    let g:windowMax=1
  endif
endfunction
nnoremap <Leader>max :call ToggleMaxWins()<CR>

:au FocusLost * :set number
:au FocusGained * :set relativenumber

autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber


" ------------------------------------------------------------------------------
"  Custom mappings
" ------------------------------------------------------------------------------
" Move to the previous buffer with "gp"
nnoremap gp :bp<CR>
nnoremap gn :bn<CR>
nnoremap gl :ls<CR>
nnoremap gb :ls<CR>:b

" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" replace currently selected text with default register with yanking it
vnoremap <leader>p "_dP

" Shortcut for clearing search highlighting
" Remapping <esc> has led to Vim opening in Replace mode. Shitty.
noremap <C-c> :noh<return>

" source $MYVIMRC
:nmap <Leader>s :source $MYVIMRC
" Open vimrc for editing
:nmap <Leader>v :e $MYVIMRC

" Use 'q' to close netrw window
autocmd FileType netrw nnoremap q :bd<CR>

" Look for a tags file going up to root
set tags=./tags;/
:nmap <Leader>cr :!ctags -R . $(python -c "import os, sys; print(' '.join('{}'.format(d) for d in sys.path if os.path.isdir(d)))")<CR>
