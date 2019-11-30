call plug#begin('~/.vim/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'Yggdroot/indentLine'
Plug 'vim-syntastic/syntastic'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-airline'
Plug 'mhinz/vim-signify'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
" Plug 'easymotion/vim-easymotion'
Plug 'mattn/Stupid-EasyMotion'
Plug 'junegunn/fzf'

call plug#end()

" { Color schemes section
"
"	{ PaperColor
set t_Co=256   " This is may or may not needed.
" set background=light
set background=dark
let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default.dark': {
  \       'transparent_background': 1
  \     }
  \   }
  \ }
color PaperColor
"	} end of PaperColor
"
" } End of color scheme section

let g:airline_theme='molokai'
" let g:airline_solarized_bg='dark'

syntax on

set autoindent
set nocompatible

set termencoding=utf-8
set encoding=utf-8

set path+=**
set shell=/bin/bash\ -i
" --configs hybrid line numbering
set number relativenumber
set showcmd
" set cursorline

filetype indent on
filetype plugin on

set wildmenu
set showmatch

set incsearch
set hlsearch

" Setting for Netrw
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 75 
let g:netrw_liststyle = 3
let g:netrw_sort_sequence = '[\/]$,*'

" Change directory to the current buffer when opening files.
" set autochdir

" indent lines
let g:indentLine_char = '|'

autocmd FileType markdown let g:indentLine_enabled=0

" Autosave and load folding view
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent! loadview

" Relative or absolute number lines
function! NumberToggle()
    if(&nu == 1)
        set nu!
        set rnu!
    else
        set nu
        set rnu
    endif
endfunction

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden = 1

" Setup of Syntastic plugin
"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" let g:syntastic_go_checkers = ["go", "govet"]

let g:syntastic_sh_checkers = ["sh"]

let g:syntastic_python_checkers = ["python"]

" let g:syntastic_markdown_checkers = ['mdl']
"
" } End of Syntastic setup

" enable Deoplete at startup
" let g:deoplete#enable_at_startup = 1

"----------------------------------------------
" Plugin: bling/vim-airline
"----------------------------------------------
" Show status bar by default.
set laststatus=2

" Enable top tabline.
let g:airline#extensions#tabline#enabled = 1
"
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" enable/disable displaying index of the buffer
let g:airline#extensions#tabline#buffer_idx_mode = 1

" Change leader key
let mapleader = " "
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab

" Disable showing tabs in the tabline. This will ensure that the buffers are
" what is shown in the tabline at all times.
let g:airline#extensions#tabline#show_tabs = 0

" Enable powerline fonts.
let g:airline_powerline_fonts = 1

"switch spellcheck languages
let g:myLang = 0
let g:myLangList = [ "nospell", "en_us", "de_de" ]
function! ToggleSpell()
  "loop through languages
  let g:myLang = g:myLang + 1
  if g:myLang >= len(g:myLangList) | let g:myLang = 0 | endif
  if g:myLang == 0 | set nospell | endif
  if g:myLang == 1 | setlocal spell spelllang=en_us | endif
  if g:myLang == 2 | setlocal spell spelllang=de_de | endif
  echo "spell checking language:" g:myLangList[g:myLang]
endfunction

map <F3> :call NumberToggle()<CR>
map <F4> :NERDTreeToggle<CR>
" Toggle Deoplete
nmap <F5> :call deoplete#toggle()<CR>
nmap <silent> <F7> :call ToggleSpell()<CR>

" My mappings to work with Windows buffer
nmap <leader>p "*p
nmap <leader>P "*P
nmap <leader>y "*yy
vmap <leader>y "*y

" FZF hotkeu
nmap <leader>f :FZF <CR>
nmap <leader>h :FZF ~ <CR>

set tabstop=8
" virtual tabstops using spaces
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
" allow toggling between local and default mode
let g:TabMode = 0
let g:TabModeList = [ "Expand Tab", "No Expand Tab" ]
function! TabToggle()
  let g:TabMode = g:TabMode + 1
  if g:TabMode >= len(g:TabModeList) | let g:TabMode = 0 | endif
  if g:TabMode == 1
    set shiftwidth=8
    set softtabstop=0
    set noexpandtab
  endif
  if g:TabMode == 0
    set shiftwidth=4
    set softtabstop=4
    set expandtab
  endif
  echo "Tab mode:" g:TabModeList[g:TabMode]
endfunction
nmap <silent> <F9> :call TabToggle()<CR>