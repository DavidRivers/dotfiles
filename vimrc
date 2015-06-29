if &shell =~# 'fish$'
  set shell=/bin/sh
endif

set clipboard=unnamed " Only for Mac?

call pathogen#infect()                                     
call pathogen#helptags()

"if has('gui_running')
	set background=light
"else
"	set background=dark
"endif
set guifont=Menlo\ Regular:h12
set nocompatible                                           
set t_Co=16                                                
set number
set cursorline
set guioptions=nomenu
set guioptions=nonavigation
colorscheme solarized                                      
syntax on
filetype plugin indent on
"set statusline+=%{fugitive#statusline()}
set laststatus=2 " Always show statusline
set mouse=a " Mouse to select window splits

let mapleader=" "
map <Leader>r :CommandTFlush<CR>
map <Leader>a :TagbarToggle<CR>
map <Leader>p :CtrlP<CR>
"map <Leader>d :bdelete<CR>
map <Leader>g :Ggrep '
map <Leader>/ :normal gcc<CR>
map <Leader>P :set paste!<CR>
"nmap <Leader>f :!touch 

""" tabs
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
"set tabline=[_%{getcwd()}_]
set list listchars=tab:¬·,trail:·,extends:→,precedes:←,conceal:✗,nbsp:┄
set nowrap
set hlsearch
set incsearch

" For CoffeeTags plugin
let g:CoffeeAutoTagDisabled=0		" Disables autotaging on save (Default: 0 [false])
let g:CoffeeAutoTagFile='./tags'       	" Name of the generated tag file (Default: ./tags)
let g:CoffeeAutoTagIncludeVars=1  	" Includes variables (Default: 0 [false])
let g:CoffeeAutoTagTagRelative=1  	" Sets file names to the relative path from the tag file location to the tag file location (Default: 1 [true])

let g:tagbar_type_coffee = {
    \ 'ctagstype' : 'coffee',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 'm:methods',
        \ 'f:functions',
        \ 'v:variables',
        \ 'f:fields',
    \ ]
    \ }

set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds

" Command-T's default <C-CR> setting to open result in (horizontal) split window isn't working
let g:CommandTAcceptSelectionSplitMap=['<C-g>']



function! NumberToggle()
        if(&relativenumber == 1)
                set number
        else
                set relativenumber
        endif
endfunc


let g:syntastic_mode_map = { 'passive_filetypes': ['scss'] }

" Following autocommands have syntax error (on the *, I think); fix this
" au FocusLost * :set number<CR>
" au FocusGained * :set relativenumber<CR>
" nnoremap <Leader>n :call NumberToggle()<CR>
"
"au WinLeave * set nocursorline nocursorcolumn
"au WinEnter * set cursorline cursorcolumn
"set cursorline cursorcolumn

let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'html.handlebars' : 1,
    \ 'php' : 1,
    \}

" For vim-commentary
autocmd FileType ruby set commentstring=#\ %s

""
" For prose formatting with par...helpful for re-flowing comments and markdown
" text.
"
" Note: In order for this to work, you'll need to both
"   1) install `par`
"   2) export PARINIT as 'rTbgqR B=.,?_A_a Q=_s>|' from your shell's
"   profile/init file.
vnoremap <Leader>= !par
nnoremap <Leader>== V!par
" TODO: Set up the above command to accept a motion.

autocmd BufNewFile,BufRead *.fish set syntax=sh
