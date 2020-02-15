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

" Statusline
Plug 'vim-airline/vim-airline'

" Undotree
Plug 'mbbill/undotree'

" Practicing movement
Plug 'takac/vim-hardtime'

call plug#end()

" Enable all Python syntax highlighting features
let python_highlight_all = 1

" Show line numbers
set number

" Spellcheck
set spell spelllang=en_us

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
if has("persistent_undo")
  set undodir=~/.cache/undodir
  set undofile
endif

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

" ALE configuration
let g:ale_linters = {
      \  'cpp': ['clangtidy'],
      \}
let g:ale_cpp_clangtidy_checks=['*']
let g:ale_fixers = {'cpp': ['clang-format']}
let g:ale_fix_on_save = 1

" Configure fzf
set runtimepath+=~/.fzf

" Debug in terminal
packadd terminaldebug

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
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
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
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
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

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

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

let g:coc_global_extensions=["coc-python", "coc-snippets"]
