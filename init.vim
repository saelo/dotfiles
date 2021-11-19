" Plugins
call plug#begin(stdpath('data') . '/plugged')

Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'

Plug 'airblade/vim-gitgutter'

Plug 'morhetz/gruvbox'

call plug#end()

" General settings
set nocompatible                " be IMproved

syntax on                       " enable syntax highligthing

filetype on                     " enable filetype detection (sets 'filetype')
filetype plugin on              " load plugin for the current filetype if available
filetype indent on              " load indent file for the current filetype if available

let mapleader=","               " set <Leader> to comma

set nomodeline                  " disable modeline support

" UI settings
colorscheme gruvbox             " set colorscheme

set number                      " show line numbers
set relativenumber              " and show them relative to the current line

set updatetime=1000             " reduce updatetime, mostly for vim-gitgutter

set showmatch                   " highlight matching brackets

set splitright                  " split vertical windows right to the current windows
set splitbelow                  " split horizontal windows below to the current windows

set confirm                     " instead of failing a command because of unsaved changes, instead raise a dialogue
                                " asking if you wish to save changed files

set backspace=indent,eol,start  " define backspace behavior in insert mode: delete autoindents, join lines at line
                                " breaks, backspace over the start of the current insertion

" Searching
set incsearch                   " show matches while typing
set hlsearch                    " highlight the search term while searching
set ignorecase                  " search case insensitive
set smartcase                   " but not when search pattern contains upper case characters

" Indention
"   These might be overwritten by filetype specific plugins
set shiftwidth=2                " use this many spaces for each level of indention
set softtabstop=2               " insert this many spaces for a tab while editing
set expandtab                   " replace tabs with spaces when editing
set autoindent                  " copy indent from current line when starting a new line

" Folding
set foldmethod=syntax           " fold based on syntactical elements
set foldminlines=0              " and even fold single lines
set foldlevelstart=99           " but start with all folds open. See :help fold-commands
set foldcolumn=auto             " show the foldcolumn if folds are present

" Autocompletion
"   Use <Tab> and <S-Tab> to perform simple Ctrl-N/Ctrl-P completion. See :help ins-completion.
"   The SmartTab function is executed via the expression register on <Tab>, see :help i_CTRL_R. This works because <C-R>
"   is allowed in the completion mode (CTRL-X). The function checks if the character before the cursor is whitespace, if
"   so it performs a regular tab key. Otherwise, it performs Ctrl-N completion.
"   The ShartShiftTab function is similar, except that it only performs Ctrl-P if the popup menu is currently visible.
function SmartTab()
  if strpart(getline('.'), col('.') - 2, 1) =~ '^\s*$'
    return "\<Tab>"
  else
    return "\<C-N>"
  endif
endfunction
function SmartShiftTab()
  if pumvisible()
    return "\<C-P>"
  else
    return "\<S-Tab>"
  endif
endfunction
inoremap <Tab> <C-R>=SmartTab()<CR>
inoremap <S-Tab> <C-R>=SmartShiftTab()<CR>

set completeopt=longest,menu,preview    " Define insert mode completion behavior: complete longest match and show menu

set wildmenu                    " enable enhanced command-line completion
set wildmode=longest:full,full  " define command completion behaviour: on first 'wildchar' (<Tab>) press, complete until
                                " longest and start 'wildmenu' (if ambigious), on 2nd press (and any subsequent one),
                                " use full completion behaviour so that pressing 'wildchar' jumps to the next match

" Navigation
"   Move up and down by physical lines when used with a count, otherwise virtual lines
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Custom highlighting
"   This should come after setting the colorscheme, as that may overwrite it
"   Gently highlight trailing whitespaces
highlight TrailingWhitespace ctermbg=darkgray guibg=darkgray
match TrailingWhitespace /\s\+$/
