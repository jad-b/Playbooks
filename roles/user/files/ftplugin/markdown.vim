set tabstop=2                   "A tab is 4 spaces
set softtabstop=2               "Insert 2 spaces when tab is pressed
set shiftwidth=2                "An indent is 2 spaces
set expandtab                   "Always uses spaces instead of tabs
set shiftround                  "Round indent to nearest shiftwidth multiple

" ---------- vim-markdown ----------
let g:vim_markdown_math = 1
" YAML
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
" Auto-indent lists by 2 spaces
let g:vim_markdown_new_list_item_indent = 1
" Follow markdown links without the '.md' extension
let g:vim_markdown_no_extensions_in_markdown = 1
let g:vim_markdown_strikethrough = 1
" Auto-save current file before following link
let g:vim_markdown_autowrite = 1
