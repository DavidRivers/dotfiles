if &shell =~# 'fish$'
  set shell=/bin/sh
endif

set clipboard=unnamed " Only for Mac?: https://robots.thoughtbot.com/how-to-copy-and-paste-with-tmux-on-mac-os-x

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
set mouse+=a " Mouse to select window splits
if &term =~ '^screen'
  " tmux knows the extended mouse mode
  set ttymouse=xterm2
endif

set autoread " automatically reload files from disk

set wildmenu
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vender/gems/*
set wildignorecase

let mapleader=" "
"map <Leader>r :CommandTFlush<CR>
map <Leader>r :CtrlPClearCache<CR>
map <Leader>gg :NERDTreeToggle<CR>
map <Leader>f :NERDTreeToggle<CR>
map <Leader>b :buffer 
map <Leader>a :TagbarToggle<CR>
map <Leader>p :CtrlP<CR>
map <Leader>d :bdelete<CR>
map <Leader>q :q<CR>
map <Leader>/ :normal gcc<CR>
map <Leader>P :set paste!<CR>
" open buffer in splits
"map <Leader>v 
"map <Leader>j
"nmap <Leader>f :!touch 
nmap <Leader>s :w<CR>
"imap <Leader>s <C-o>:w<CR> " causes an annoying delay after typing space in
"insert mode

""" tabs
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
"set tabline=[_%{getcwd()}_]
set list listchars=tab:¬·,trail:·,extends:→,precedes:←,conceal:✗,nbsp:┄
"set nowrap
set hlsearch
set incsearch

""" splits
set splitbelow
set splitright

""" Ctrl-P ignore options
set wildignore+=*/node_modules/*,*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\node_modules\\*,*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

" Fugitive "
nnoremap <Leader>g :Ggrep '
nnoremap <Leader>gg :Gstatus<CR>
nnoremap <Leader>gd :Gvdiff<CR>
nnoremap <Leader>gh :Gbrowse<CR>
nnoremap <Leader>gH :Gbrowse!<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gl :Glog<CR>
vnoremap <Leader>gd :Gdiff<CR>
vnoremap <Leader>gh :Gbrowse<CR>
vnoremap <Leader>gH :Gbrowse!<CR>
vnoremap <Leader>gb :Gblame<CR>
vnoremap <Leader>gl :Glog<CR>
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("h")': ['<c-j>', '<c-x>', '<c-cr>', '<c-s>'],
    \ }

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

"" Command-T's default <C-CR> setting to open result in (horizontal) split window isn't working
"let g:CommandTAcceptSelectionSplitMap=['<C-g>']



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
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn

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

" upon hitting escape to change modes,
" send successive move-left and move-right
" commands to immediately redraw the cursor
inoremap <special> <Esc> <Esc>hl

" Mode-dependent cursor
" http://blog.terriblelabs.com/blog/2013/02/09/stupid-vim-tricks-how-to-change-insert-mode-cursor-shape-with-tmux/
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
" upon hitting escape to change modes,
" send successive move-left and move-right
" commands to immediately redraw the cursor
"inoremap <special> <Esc> <Esc>hl
"" don't blink the cursor
"set guicursor+=i:blinkwait0
