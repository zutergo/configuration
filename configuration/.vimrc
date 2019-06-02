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

" Update ctags and csope files 
Plugin 'ludovicchabant/vim-gutentags.git'

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

" Utf-8 support
set encoding=utf-8

" Colorscheme
set background=dark
colorscheme gruvbox

" Open NERDTree with Ctrl+n
map <C-n> :NERDTreeToggle<CR>

" Avoid swap files
set noswapfile

" Persistent undo
set undodir=~/.cache/undodir
set undofile

" Copy and paste from clipboard
set clipboard+=unnamed

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
set tags+=~/.cache/tags/;

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

" Gutentags configuration
let g:gutentags_modules = ['ctags', 'cscope']
let g:gutentags_cache_dir = expand('~/.cache/tags')
let g:gutentags_project_root = ['.project', 'Makefile'] 
let g:gutentags_plus_switch=1

" Configure fzf
set runtimepath+=~/.fzf

function! Cscope(option, query)
  let color = '{ x = $1; $1 = ""; z = $3; $3 = ""; printf "\033[34m%s\033[0m:\033[31m%s\033[0m\011\033[37m%s\033[0m\n", x,z,$0; }'
  let opts = {
  \ 'source':  "cscope -dL" . a:option . " " . a:query . " | awk '" . color . "'",
  \ 'options': ['--ansi', '--prompt', '> ',
  \             '--multi', '--bind', 'alt-a:select-all,alt-d:deselect-all',
  \             '--color', 'fg:188,fg+:222,bg+:#3a3a3a,hl+:104'],
  \ 'down': '40%'
  \ }
  function! opts.sink(lines) 
    let data = split(a:lines)
    let file = split(data[0], ":")
    execute 'e ' . '+' . file[1] . ' ' . file[0]
  endfunction
  call fzf#run(opts)
endfunction

command! Cscope call Cscope('0', expand('<cword>'))
