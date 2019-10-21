if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * Plugstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Default vim settings
Plug 'tpope/vim-sensible'

" Directory navigation 
Plug 'scrooloose/nerdtree'

" Color scheme Plugs
Plug 'morhetz/gruvbox'

" Folding Plug
Plug 'pseewald/anyfold'

" Autoclose Plug
Plug 'Raimondi/delimitMate'

" Asynchroneuos build
Plug 'tpope/vim-dispatch'

" Snippet Plugs
"Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Search for files
Plug 'junegunn/fzf.vim'

" Autocompletion with Language Server Protocol
Plug 'neoclide/coc.nvim', {'branch': 'release'}
    
" Linter for all languages
Plug 'dense-analysis/ale'

" Git support
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Practicing movement
Plug 'takac/vim-hardtime'

call plug#end()

" Enable all Python syntax highlighting features
let python_highlight_all = 1

" Show line numbers
set number

" Set tabs
set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2

" Colorscheme
set background=dark
colorscheme gruvbox

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

" Open NERDTree with Ctrl+n
map <C-n> :NERDTreeToggle<CR>

" Avoid swap files
set noswapfile

" Persistent undo
set undodir=~/.cache/undodir
set undofile

" Copy and paste from clipboard
set clipboard+=unnamed

" For better searching
set hlsearch
set ignorecase

" Allow switching unsaved buffers 
set hidden

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
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1

" Configure fzf
set runtimepath+=~/.fzf

" Autocompletion configuration

" Some servers have issues with backup files
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Using CocList
" Show all diagnostics
nnoremap <silent> <leader>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <leader>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <leader>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <leader>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <leader>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <leader>p  :<C-u>CocListResume<CR>
let g:coc_snippet_next = '<tab>'
