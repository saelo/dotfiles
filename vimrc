"
" Plugins
"
call plug#begin('~/.vim/plugins')

Plug 'scrooloose/nerdtree'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'

Plug 'ervandew/supertab'
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'mileszs/ack.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'terryma/vim-expand-region'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'wellle/targets.vim'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'matze/vim-move'

Plug 'keith/swift.vim'
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go'
Plug 'saelo/smarttrim.vim'

Plug 'tomasr/molokai'
Plug 'altercation/vim-colors-solarized'

call plug#end()


"
" General settings
"
set nocompatible            " be IMproved

filetype plugin indent on   " enable indention based on filetype

syntax on                   " enable syntax highligthing

set number                  " show line numbers
set relativenumber          " and show them relative to the current line

set laststatus=2            " always show status bar
set ttimeoutlen=50          " low timout when leaving insert mode

set spelllang=en            " set spellcheck language

set mouse=a                 " enable mouse support

set splitright              " split vertical windows right to the current windows
set splitbelow              " split horizontal windows below to the current windows

set synmaxcol=500           " Workaround, overly long lines cause problems...

set showmatch               " highlight matching [{()}]

" Searching
set showcmd                 " show partial commands while typing
set incsearch               " show matches while typing
set hlsearch                " highlight all matches
set ignorecase              " search case insensitive...
set smartcase               " ... but not when search pattern contains upper case characters

"show search matches in the middle of the window
"nnoremap n nzz
"nnoremap N Nzz

" Ignore binary/build files when completing/searching
set wildignore+=*.so,*.swp,*.zip,*.o,.git/*,.hg/*,.svn/*,*.db

" Folding
set foldmethod=indent   " fold by indention level
set foldcolumn=4        " show up to 4 levels of indention on the left
set foldlevel=10        " show ten levels of indetion by default

" Indention
set shiftwidth=4        " use 4 spaces for each level of indetion
set tabstop=4           " show tabs as 4 spaces
set expandtab           " replace tabs with spaces

set backspace=indent,eol,start              " make backspace key more powerful in insert mode

set wildmenu wildmode=longest:full,full     " command autocompletion: complete as much as possible and show remaining choices

" improve the menu completion
set completeopt=menu,menuone,longest

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Enable persistent undo
set undodir=~/.vim/undo
set undofile

" Type w!! to write file as root
cmap w!! w !sudo tee % >/dev/null

" Set <leader> to <space>
let mapleader="\<Space>"


"
" Navigation
"
" navigate by display lines, not file lines
"noremap  <buffer> <silent> k gk
"noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$
" Navigate by physical lines when used with a count, otherwise use virtual lines
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')


"
" Mappings
"
" clear currently highlighted search items when hitting <Space>
nmap <silent> <Space> :nohlsearch <Bar> :echo<CR>

" remap the * to highlight all matches of the word under the cursor but don't
" move to the next occurance
nmap <silent> * :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" Easier copy+paste to system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P


"
" Plugin specific settings
"

" Ack settings
let g:ackprg = 'ag --vimgrep'           " Use ag instead
nmap ` :Ack!<cr>                        " search for the word under the cursor


" Airline settings
let g:airline_theme = 'molokai'
let g:airline_powerline_fonts = 1               " make sure powerline fonts are installed: https://powerline.readthedocs.org/en/latest/installation/linux.html
"let g:airline#extensions#tabline#enabled = 1    " show buffers as tabs


" vim-move settings
let g:move_key_modifier = 'C'           " use <C-j> and <C-k>


" Ctrl-P settings
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40

" make CtrlPBuffer the default action and use <leader> for the others
let g:ctrlp_cmd = 'CtrlPBuffer'
nnoremap <leader>f :CtrlP<cr>
nnoremap <leader>m :CtrlPMRU<cr>
nnoremap <leader>b :CtrlPBuffer<cr>


" vim-expand-region settings -- incremental visual mode
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)


"
" Colorscheme
"
set background=dark
colorscheme molokai

highlight clear LineNr                  " transparent line number column
highlight clear FoldColumn              " transparent fold column
highlight clear Folded                  " transparent fold block background
highlight clear SignColumn              " clear SignColumn style thus forcing same style for git column and number column


"
" Abbreviations
"
ab cpsg Copyright (c) 2017 Samuel Groß
