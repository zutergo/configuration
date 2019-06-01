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

" When using >> or << commnads, shift lines by 4 spaces
set shiftwidth=2

" |:split filename| will put the new window below
set splitbelow

" |vsplit filename| will put the new window right
set splitright

" Enable folding 
autocmd Filetype * AnyFoldActivate
set foldlevel=0

" Enable folding with the spacebar
nnoremap <space> zA

" Remap escape key
inoremap jk <Esc>

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

" Do not redraw while executing macros (good performance config)
"set lazyredraw

" Increase the amount of history of command line
set history=200

" Set statusline
set laststatus=2
set statusline=
set statusline+=%#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#DiffChange#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#DiffDelete#%{(mode()=='r')?'\ \ RPLACE\ ':''}
set statusline+=%#Cursor#%{(mode()=='v')?'\ \ VISUAL\ ':''}
set statusline+=\ %n\                     " Buffer number
set statusline+=%#Visual#                 " Colour
set statusline+=%{&paste?'\ PASTE\ ':''}
set statusline+=%{&spell?'\ SPELL\ ':''}
set statusline+=%#CursorIM#               " Colour
set statusline+=%R                        " Readonly flag
set statusline+=%M                        " Modified [+] flag
set statusline+=%#Cursor#                 " Colour
set statusline+=%#CursorLine#             " Colour
set statusline+=\ %t\                     " Short file name
set statusline+=%=                        " Right align
set statusline+=%#CursorLine#             " Colour
set statusline+=\ %Y\                     " File type
set statusline+=%#CursorIM#               " Colour
set statusline+=\ %3l:%-2c\               " Line + Column
set statusline+=%#Cursor#                 " Colour
set statusline+=\ %3p%%\                  " Percentage

" ALE configuration
let g:ale_cpp_clangtidy_checks=['*']

" Configure fzf
set runtimepath+=~/.fzf
let g:fzf_tags_command = 'ctags --extra=+f -R'
"
" Default fzf layout
let g:fzf_layout = { 'down': '~40%' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
 \ { 'fg':      ['fg', 'Normal'],
 \ 'bg':      ['bg', 'Normal'],
 \ 'hl':      ['fg', 'Comment'],
 \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
 \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
 \ 'hl+':     ['fg', 'Statement'],
 \ 'info':    ['fg', 'PreProc'],
 \ 'border':  ['fg', 'Ignore'],
 \ 'prompt':  ['fg', 'Conditional'],
 \ 'pointer': ['fg', 'Exception'],
 \ 'marker':  ['fg', 'Keyword'],
 \ 'spinner': ['fg', 'Label'],
 \ 'header':  ['fg', 'Comment'] }

" Enable per-command history
let g:fzf_history_dir='~/.local/share/fzf-history'

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always
            \ --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" Command for git grep
 " - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
 \ call fzf#vim#grep(
 \ 'git grep --line-number '.shellescape(<q-args>), 0,
 \ { 'dir': systemlist('git rev-parse --show-toplevel')[0] },
 \ <bang>0)

" Augmenting Ag command using fzf#vim#with_preview function
command! -bang -nargs=* Ag
 \ call fzf#vim#ag(<q-args>,
 \ <bang>0 ? fzf#vim#with_preview('up:60%')
 \         : fzf#vim#with_preview('right:50%:hidden', '?'),
 \ <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
 \ call fzf#vim#files(<q-args>,
 \ fzf#vim#with_preview(), <bang>0)
