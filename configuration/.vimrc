" required for vundle
set nocompatible
filetype off

" Set the runtime path to include vundle
set runtimepath+=~/.vim/bundle/Vundle.vim

" Initialize vundle
call vundle#begin()

" Let vundle manage plugins
Plugin 'VundleVim/Vundle.vim'

" Default vim settings
Plugin 'tpope/vim-sensible'

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

" Snippet plugins
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" Search for files
Plugin 'junegunn/fzf.vim'

" Autocompletion with Language Server Protocol
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'
Plugin 'prabirshrestha/asyncomplete-buffer.vim'
Plugin 'prabirshrestha/asyncomplete-file.vim'
Plugin 'prabirshrestha/asyncomplete-ultisnips.vim'
    
" Linter for all languages
Plugin 'w0rp/ale'

" Git support
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" Practicing movement
Plugin 'takac/vim-hardtime'

" All plugins must be added before the following line
call vundle#end()

" Enable all Python syntax highlighting features
let python_highlight_all = 1

" Show line numbers
set number

" Set tabs
set tabstop=2
set softtabstop=2
set expandtab
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
set ignorecase

" Easy split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Map leader key to ","
let mapleader = ","

" Set statusline
set statusline=
set statusline+=%<\                       " cut at start
set statusline+=%2*[%n%H%M%R%W]%*\        " flags and buf no
set statusline+=%-40f\                    " path
set statusline+=%=%1*%y%*%*\              " file type
set statusline+=%10((%l,%c)%)\            " line and column
set statusline+=%P                        " percentage of file

" ALE configuration
let g:ale_cpp_clangtidy_checks=['*']
let g:ale_fixers = {'cpp': ['clang-format']}

" Configure fzf
set runtimepath+=~/.fzf

" Clangd configuration for Language Server Protocol
if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd', '-background-index']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif

" Autocompletion configuration
imap <c-space> <Plug>(asyncomplete_force_refresh)
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

if has('python3')
    let g:UltiSnipsExpandTrigger="<c-e>"
    call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
        \ 'name': 'ultisnips',
        \ 'whitelist': ['*'],
        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
        \ }))
endif

call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'whitelist': ['*'],
    \ 'blacklist': ['go'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'config': {
    \    'max_buffer_size': 5000000,
    \  },
    \ }))

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'whitelist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))
