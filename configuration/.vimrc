" required for vundle
set nocompatible
filetype off

" Set the runtime path to include vundle
set runtimepath+=~/.vim/bundle/Vundle.vim

" Initialize vundle
call vundle#begin()

" Let vundle manage plugins
Plugin 'VundleVim/Vundle.vim'

" Directory navigation 
Plugin 'scrooloose/nerdtree'

" Color scheme plugins
Plugin 'morhetz/gruvbox'

" Folding plugin
Plugin 'pseewald/anyfold'

" Autoclose plugin
Plugin 'Raimondi/delimitMate'

" Asynchroneuos build
Plugin 'tpope/vim-dispatch'

" Autocompletion plugin
Plugin 'ervandew/supertab'
Plugin 'Valloric/YouCompleteMe'

" Snippet plugins
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" Search for files
Plugin 'junegunn/fzf.vim'

" Linter for all languages
Plugin 'w0rp/ale'

" Git support
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" All plugins must be added before the following line
call vundle#end()

" Loading the indent file, required for vundle
filetype plugin indent on

" Enable syntax highlighting
syntax enable

" Enable all Python syntax highlighting features
let python_highlight_all = 1

" Show line numbers
set number

" Set tabs
set tabstop=2
set softtabstop=2

" Expand tabs into spaces
set expandtab

" Indent when moving to next line while writing code
set autoindent

" Set shiftwidth 
set shiftwidth=2

" |:split filename| will put the new window below
set splitbelow

" |vsplit filename| will put the new window right
set splitright

" Enable folding 
autocmd Filetype * AnyFoldActivate
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> zA

" Remap escape key
inoremap jk <Esc>

" Python configuration
" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/

" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Utf-8 support
set encoding=utf-8

" Colorscheme
set background=dark
colorscheme gruvbox

" Open NERDTree with Ctrl+n
map <C-n> :NERDTreeToggle<CR>

" Avoid swap files
set noswapfile

" No error if buffer is not saved
set hidden

" For better searching
set hlsearch
set incsearch
set ignorecase

" Easy split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Find tags file in subfolders
set tags=./tags;/

" Make YouCompleteMe compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" Better key bindings for UltiSnipsExpandTrigger
set runtimepath+=~/.vim/mysnippets/
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Map leader key to ","
let mapleader = ","

" Increase the amount of history of command line
set history=200

" Set statusline
set laststatus=2
set statusline=
set statusline+=%<\                       " cut at start
set statusline+=%2*[%n%H%M%R%W]%*\        " flags and buf no
set statusline+=%-40f\                    " path
set statusline+=%=%1*%y%*%*\              " file type
set statusline+=%10((%l,%c)%)\            " line and column
set statusline+=%P                        " percentage of file

" ALE configuration
let g:ale_cpp_clangtidy_checks=['*']

" Configure fzf
set runtimepath+=~/.fzf
