"
" Vundle
"
set nocompatible        " be IMproved
filetype off            " required, reverted below

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ "
"                     Plugins                         "
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ "
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'edkolev/tmuxline.vim'
Plugin 'rking/ag.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'fatih/vim-go'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'terryma/vim-expand-region'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'wellle/targets.vim'
Plugin 'justinmk/vim-sneak'
Plugin 'keith/swift.vim'
Plugin 'tpope/vim-surround'
Plugin 'matze/vim-move'
Plugin 'rust-lang/rust.vim'

Plugin 'altercation/vim-colors-solarized'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"
" Settings
"
set number              " show line numbers
set relativenumber      " and show them relative to the current line
set laststatus=2        " always show status bar
set ttimeoutlen=50      " low timout when leaving insert mode

set spelllang=en        " set spellcheck language

syntax on               " enable syntax highligthing

set mouse=a             " enable mouse support

set splitright          " split vertical windows right to the current windows
set splitbelow          " split horizontal windows below to the current windows

set ttyfast

set synmaxcol=500       " Workaround, overly long lines cause problems...

set showmatch           " highlight matching [{()}]

"
" Searching
"
set showcmd             " show partial commands while typing
set incsearch           " show matches while typing
set hlsearch            " highlight all matches
set ignorecase          " search case insensitive...
set smartcase           " ... but not when search pattern contains upper case characters

"show search matches in the middle of the window
nnoremap n nzz
nnoremap N Nzz

" Ignore binary/build files when completing/searching
set wildignore+=*/build/*,*.so,*.swp,*.zip,*.o,.git/*,.hg/*,.svn/*,*.db

"
" Folding
"
set foldmethod=indent   " fold by indention level
set foldcolumn=4        " show up to 4 levels of indention on the left
set foldlevel=10        " show ten levels of indetion by default

"
" Indention
"
set shiftwidth=4        " use 4 spaces for each level of indetion
set tabstop=4           " show tabs as 4 spaces
set expandtab           " replace tabs with spaces

set backspace=indent,eol,start              " make backspace key more powerful in insert mode

set wildmenu wildmode=longest:full,full     " command autocompletion: complete as much as possible and show remaining choices


" improve the complete menu
set completeopt=menu,menuone,longest

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Type w!! to write file as root
cmap w!! w !sudo tee % >/dev/null

" Set <leader> to <space>
let mapleader = "\<Space>"

" Easier copy+paste to system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P


"
" Navigation
"
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" navigate by display lines, not file lines
"noremap  <buffer> <silent> k gk
"noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$
" Navigate by physical lines when used with a count, otherwise use virtual lines
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Incremental visual mode
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)


"
" Mappings
"
nmap <F7> :NERDTreeToggle<CR>

" clear currently highlighted search items when hitting <Space>
nmap <silent> <Space> :nohlsearch <Bar> :echo<CR>

" remap the * to highlight all matches of the word under the cursor but don't
" move to the next occurance
nmap <silent> * :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" search for the selected word in the current directory
nmap ` :Ag! <c-r>=expand("<cword>")<cr><cr>

"
" Automatically trim trailing whitespace when saving files.
"
function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction

"autocmd FileWritePre   * :call TrimWhiteSpace()
"autocmd FileAppendPre  * :call TrimWhiteSpace()
"autocmd FilterWritePre * :call TrimWhiteSpace()
"autocmd BufWritePre    * :call TrimWhiteSpace()

" Use visual bell instead of beeping when doing something wrong
set noerrorbells visualbell

"
" Abbreviations
"
ab cpsg Copyright (c) 2017 Samuel Groß


"
" Airline settings.
"
let g:airline_theme = 'molokai'
let g:airline_powerline_fonts = 1       " make sure powerline fonts are installed: https://powerline.readthedocs.org/en/latest/installation/linux.html
let g:airline#extensions#tabline#enabled = 1

"
" YouCompleteMe settings.
"
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_complete_in_comments = 1
" Load .ycm_extra_conf.py files automatically if they are in ~/Workspace.
" let g:ycm_extra_conf_globlist = ['~/Workspace/*', '/Volumes/Workspace/*']
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

"
" Ctrl-P settings.
"
nnoremap <C-B> :CtrlPBuffer<CR>
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40


"
" Colorscheme
"
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized

highlight clear LineNr                  " transparent line number column
highlight clear FoldColumn              " transparent fold column
highlight clear Folded                  " transparent fold block background
highlight clear SignColumn              " clear SignColumn style thus forcing same style for git column and number column

highlight Search ctermfg=darkgreen      " color for search highlighting
highlight Search guifg=darkgreen
