set nocompatible              " be iMproved, required
set t_Co=256
set ff=unix

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.local/share/nvim/plugged')
" ~~~~~~~~~~~~~~ Vim Itself ~~~~~~~~~~~~~~
"
Plug 'chrisbra/unicode.vim'
" Colorscheme
Plug 'altercation/vim-colors-solarized'
" Netrw improvements
Plug 'tpope/vim-vinegar'
" gpg inside vim
Plug 'jamessan/vim-gnupg'
" Commonly-used mappings
Plug 'tpope/vim-unimpaired'
" Track the engine.
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
" Allows toggling between relative and absolute line numbers with C-n
Plug 'jeffkreeftmeijer/vim-numbertoggle'
" Improve the status bar
Plug 'vim-airline/vim-airline'
" List open buffers
Plug 'bling/vim-bufferline'
" Tagbar
Plug 'majutsushi/tagbar'
" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Commands for working with surrounding text objects
Plug 'tpope/vim-surround'
" Quick (un)comment commands
Plug 'scrooloose/nerdcommenter'
" Smarter code folding
Plug 'tmhedberg/SimpylFold'
" Display tmux status bar
" Plug 'edkolev/tmuxline.vim'
Plug 'tpope/vim-dispatch'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'neomake/neomake'

" ~~~~~~~~~~~~~~ Language support ~~~~~~~~~~~~~~
" https://github.com/ElmCast/elm-vim
Plug 'elmcast/elm-vim'
Plug 'dense-analysis/ale'
Plug 'fatih/vim-go' " Go support
Plug 'chase/vim-ansible-yaml'
" Python
Plug 'tell-k/vim-autopep8' " Python - automatic pep8 fixes
Plug 'vim-scripts/indentpython.vim' " Python PEP8 Indenting
"Plug 'klen/python-mode' " Too much!
Plug 'hashivim/vim-hashicorp-tools' " HCL format
" Plug 'JuliaEditorSupport/julia-vim' " Julia
Plug 'godlygeek/tabular' " Quickly align text
Plug 'plasticboy/vim-markdown' " Markdown
Plug 'cespare/vim-toml' " TOML
" Plug 'derekwyatt/vim-scala' " Scala
Plug 'rust-lang/rust.vim'
" Haskell
Plug 'bitc/vim-hdevtools'
Plug 'neovimhaskell/haskell-vim'
Plug 'chrisdone/vim-hindent'
Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }
Plug 'hspec/hspec'
Plug 'eagletmt/ghcmod-vim'
" Plug 'parsonsmatt/intero-neovim'

" ~~~~~~~~~~~~~~ Front-end Development ~~~~~~~~~~~~~~
" Close HTML/XML tags with ctrl-_
Plug 'vim-scripts/closetag.vim'
Plug 'hail2u/vim-css3-syntax'
" JavaScript Syntax
Plug 'pangloss/vim-javascript'
" TypeScript
" Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'Quramy/tsuquyomi'

call plug#end()

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif
" ------------------------------------------------------------------------------
"  Plugin Configuration
" ------------------------------------------------------------------------------
"  ALE
nmap <C-Up> <Plug>(ale_previous_wrap)
nmap <C-Down> <Plug>(ale_next_wrap)
let g:ale_set_quickfix = 1

" ansible
let g:ansible_options = {'ignore_blank_lines': 0}

"  deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('sources', {
\ '_': ['ale'],
\})

" fzf
set rtp+=~/src/github.com/junegunn/fzf
nnoremap <C-p> :FZF <CR>
nnoremap <leader>f :FZF ~<CR>
nnoremap <leader>g :FZF system("git rev-parse --show-toplevel")<CR>

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

" vim-hdevtools
let g:hdevtools_stack = 1

" ---------- tag-bar ----------
nmap <F8> :TagbarToggle<CR>

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

" -------- linting --------

" ------------------------------------------------------------------------------
set omnifunc=syntaxcomplete#Complete
" Converts italicized,bold,etc. into the actual appearance.
set conceallevel=2

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
" Tab complete by LCS, then fullest match (:help wildmode)
" src: https://stackoverflow.com/a/11583850
set wildmode=list:longest,full
" Normal mode
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==

" Insert mode
" inoremap <C-j> <ESC>:m .+1<CR>==gi
" inoremap <C-k> <ESC>:m .-2<CR>==gi

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

" Alt-{hjkl} for navigating panes
" <C-\><C-n> is neovim's escape sequence
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

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
" autocmd BufEnter * silent! lcd %:p:h

" Remove trailing whitespace
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

autocmd Filetype yaml,html,htmldjango,ruby,kivy,tmpl,css,hbs,scss,sh setlocal autoindent tabstop=2 shiftwidth=2 expandtab
autocmd BufRead,BufNewFile *.ts set filetype=typescript
autocmd BufRead,BufNewFile *.conf set filetype=conf autoindent tabstop=2 shiftwidth=2 expandtab
autocmd BufRead,BufNewFile *.scss set filetype=css
autocmd BufRead,BufNewFile *.deploy set filetype=yaml
autocmd BufRead,BufNewFile *.yml set filetype=yaml
autocmd BufRead,BufNewFile Vagrantfile* set filetype=ruby
autocmd BufRead,BufNewFile *.txt set filetype=markdown
autocmd BufRead,BufNewFile Dockerfile.* set filetype=dockerfile
autocmd BufNewFile,BufRead *.groovy  set filetype=groovy
autocmd BufNewFile,BufRead *.jl  set filetype=julia

" Automatically close the HTML tag once you type '</ SPACE'
" http://vim.wikia.com/wiki/Auto_closing_an_HTML_tag
:iabbrev </ </<C-X><C-O>

" Turn on spell-checking in text files
au BufRead,BufNewFile *.txt,*.rst setlocal sw=2 ts=2 expandtab tw=0
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

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" ------------------------------------------------------------------------------
"  Custom mappings
" ------------------------------------------------------------------------------
" Move to the previous buffer with "gp"
nnoremap gp :bp<CR>
nnoremap gn :bn<CR>
nnoremap gl :ls<CR>
nnoremap gb :ls<CR>:b

" replace currently selected text with default register with yanking it
vnoremap <leader>p "_dP

" Shortcut for clearing search highlighting
" Remapping <esc> has led to Vim opening in Replace mode. Shitty.
noremap <C-c> :noh<return>

" source $MYVIMRC
:nmap <Leader>s :source $MYVIMRC
" Open vimrc for editing
:nmap <Leader>v :e ~/.vimrc

" Use 'q' to close netrw window
autocmd FileType netrw nnoremap q :bd

" Look for a tags file going up to root
set tags=./tags;/
:nmap <Leader>cr :!ctags -R . $(python -c "import os, sys; print(' '.join('{}'.format(d) for d in sys.path if os.path.isdir(d)))")<CR>
