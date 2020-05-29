" #####################################################
" #           _    ____                   __          #
" #          / \  / ___|  ___ ___  _ __  / _|         #
" #         / _ \| |  _  / __/ _ \| '_ \| |_          #
" #        / ___ \ |_| || (_| (_) | | | |  _|         #
" #       /_/   \_\____(_)___\___/|_| |_|_|           #
" #                                                   #
" #       Alexey Gumirov's generic config for         #
" #       Ubuntu based operating systems.             #
" #####################################################
call plug#begin('~/.vim/plugged')

if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
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
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" { integration with lf
Plug 'ptzz/lf.vim'
"wrapper for floating window
Plug 'voldikss/vim-floaterm'
" }
Plug 'dhruvasagar/vim-table-mode'

call plug#end()

" { Color schemes section
"
"   { PaperColor
" set t_Co=256   " This is may or may not needed.
" set background=light
set background=dark
let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default': {
  \       'transparent_background': 0,
  \       'allow_bold': 1,
  \       'allow_italic': 1
  \     }
  \   }
  \ }
color PaperColor
"   } end of PaperColor
" } End of color scheme section

let g:airline_theme='papercolor'
" let g:airline_solarized_bg='dark'

syntax on

set autoindent
set nocompatible

set termencoding=utf-8
set encoding=utf-8

set path+=**
set shell=/bin/bash
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
set ignorecase
set smartcase

" Change leader key
let mapleader = " "

" Vim Split settings
set splitbelow splitright

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <silent> <C-Left> :vertical resize -5<CR>
nnoremap <silent> <C-Right> :vertical resize +5<CR>
nnoremap <silent> <C-Up> :resize -2<CR>
nnoremap <silent> <C-Down> :resize +2<CR>

map <leader>sv <C-w>t<C-w>H
map <leader>sh <C-w>t<C-w>K

" set fillchars+=vert:\ 

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
let g:indentLine_concealcursor = 'ic'
let g:indentLine_enabled = 0
autocmd FileType json let g:indentLine_enabled=1
autocmd FileType sh let g:indentLine_enabled=1
autocmd FileType python let g:indentLine_enabled=1
autocmd FileType go let g:indentLine_enabled=1

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
let g:deoplete#enable_at_startup = 0

autocmd Filetype python call deoplete#enable()
autocmd Filetype markdown call deoplete#enable()
autocmd Filetype javascript call deoplete#enable()
autocmd Filetype sh call deoplete#enable()
autocmd Filetype go call deoplete#enable()

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

" tab formatter
let g:airline#extensions#tabline#formatter = 'default'

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
nmap <leader>= <Plug>AirlineSelectNextTab

" Disable showing tabs in the tabline. This will ensure that the buffers are
" what is shown in the tabline at all times.
let g:airline#extensions#tabline#show_tabs = 0

" Enable powerline fonts.
let g:airline_powerline_fonts = 1

"switch spellcheck languages
let g:myLang = 0
let g:myLangList = [ "nospell", "en_us", "de_de", "ru_ru" ]
function! ToggleSpell()
    "loop through languages
    let g:myLang = g:myLang + 1
    if g:myLang >= len(g:myLangList) | let g:myLang = 0 | endif
    if g:myLang == 0 | set nospell | endif
    if g:myLang == 1 | setlocal spell spelllang=en_us | endif
    if g:myLang == 2 | setlocal spell spelllang=de_de | endif
    if g:myLang == 2 | setlocal spell spelllang=ru_ru | endif
    echo "spell checking language:" g:myLangList[g:myLang]
endfunction

"switch Deoplete status
let g:myDeoplete = 0
let g:myDeopleteStatusList = [ "Disabled", "Enabled" ]
function! MyToggleDeoplete()
    "loop through Deoplete status
    let g:myDeoplete = g:myDeoplete + 1
    if g:myDeoplete >= len(g:myDeopleteStatusList) | let g:myDeoplete = 0 | endif
    if g:myDeoplete == 0 | call deoplete#disable() | endif
    if g:myDeoplete == 1 | call deoplete#enable() | endif
    echo "Deoplete is" g:myDeopleteStatusList[g:myDeoplete]
endfunction

map <F3> :call NumberToggle()<CR>
" Toggle Deoplete
nmap <F5> :call MyToggleDeoplete()<CR>
nmap <silent> <F7> :call ToggleSpell()<CR>

" My mappings to work with Windows buffer
nmap <leader>p "*p
nmap <leader>P "*P
nmap <leader>y "*yy
vmap <leader>y "*y

" FZF
let g:fzf_layout = { 'up':'~90%', 'window': { 'width': 0.9, 'height': 0.9, 'xoffset': 0.5, 'yoffset': 0.5} }
let g:fzf_preview_window = 'right:60%'
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', 'bat {}', '--preview-window=right:60%']}, <bang>0)
command! -bang -nargs=? Rg call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%'), <bang>0)
nmap <leader>ff :Files %:p:h<CR>
nmap <leader>fh :Files ~<CR>
function Rghome()
    :cd ~/
    :Rg
endfunction
nmap <leader>rh :call Rghome()<CR>
function Rghere()
    :cd %:p:h
    :Rg
endfunction
nmap <leader>rr :call Rghere()<CR>

set tabstop=4
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
    if g:TabMode == 0
        set shiftwidth=4
        set softtabstop=4
        set expandtab
    endif
    if g:TabMode == 1
        set shiftwidth=4
        set softtabstop=0
        set noexpandtab
    endif
    echo "Tab mode:" g:TabModeList[g:TabMode]
endfunction
nmap <silent> <F9> :call TabToggle()<CR>

let g:TagConLevel = 0
let g:TagConLevelList = [ "level is 2", "level is 0" ]
function! TagConcealLevel()
    let g:TagConLevel = g:TagConLevel + 1
    if g:TagConLevel >= len(g:TagConLevelList) | let g:TagConLevel = 0 | endif
    if g:TagConLevel == 1
        set conceallevel=0
        set concealcursor=""
    endif
    if g:TagConLevel == 0
        set conceallevel=2
        set concealcursor-=n
    endif
    echo "Conceal " g:TagConLevelList[g:TagConLevel]
endfunction
nmap <leader>c :call TagConcealLevel()<CR>
autocmd FileType markdown set conceallevel=0 | set concealcursor=""

" change path to file path
nmap <leader>l :cd %:p:h<CR>:pwd<CR>

" commands to insert my headers
function MyHeader(header)
    let @o=system("bash -c 'cat ~/.config/myheaders/" . expand(a:header) . "'")
    norm gg"oP
endfunction
command -bang -nargs=0 MyHeaderHome :call MyHeader('home')
command -bang -nargs=0 MyHeaderWork :call MyHeader('work')
command -bang -nargs=0 MyHeaderOther :call MyHeader('other_ubuntu')
command -bang -nargs=0 MyYAMLheader :call MyHeader('AGheader.yaml')
command -bang -nargs=0 MyYAMLPNheader :call MyHeader('PNheader.yaml')

set listchars=tab:≫.,trail:⇒,eol:▼,nbsp:▊
set nolist
let g:ListMode = 0
let g:ListModeList = [ "List OFF", "List ON" ]
function! ListModeToggle()
    let g:ListMode = g:ListMode + 1
    if g:ListMode >= len(g:ListModeList) | let g:ListMode = 0 | endif
    if g:ListMode == 0
        setlocal nolist
    endif
    if g:ListMode == 1
        " setlocal fileencoding=utf-8
        set listchars=tab:≫.,trail:⇒,eol:▼,nbsp:▊
        setlocal list
    endif
    echo "List mode:" g:ListModeList[g:ListMode]
endfunction
nmap <silent> <F8> :call ListModeToggle()<CR>

" Vim commentary. Adding my file types
autocmd FileType toml setlocal commentstring=#%s
autocmd FileType openhab setlocal commentstring=//%s

" gitgutter line numbers highlight
let g:gitgutter_highlight_linenrs = 1

" autocommenting toggle
map <silent> <leader>ac :setlocal formatoptions-=cro<CR>
map <silent> <leader>aC :setlocal formatoptions=cro<CR>

" LF
command! LF FloatermNew lf
let g:floaterm_height = 0.8
let g:floaterm_width = 0.8
let g:floaterm_rootmarkers = ['.git', '.gitignore']
hi Floaterm guibg=black
let g:lf_replace_netrw = 1
let g:lf_map_keys = 0
nmap <leader>o :LF<CR>

"Command to insert hash
function MySha256Hash()
    let @s = system("date +'\%s' | sha256sum | cut -d' ' -f1 | tr -d '\n'")
    norm "sp
endfunction
nmap <silent> <leader>d :call MySha256Hash()<CR>

"Table mode plugin config for GitHub flavored tables
let g:table_mode_corner='|'
