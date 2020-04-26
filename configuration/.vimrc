if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * Plugstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Default vim settings
Plug 'tpope/vim-sensible'

" Color scheme Plugs
Plug 'morhetz/gruvbox'

" Folding plugin
Plug 'pseewald/anyfold'

" Autoclose Plug
Plug 'jiangmiao/auto-pairs'

" Comment code
Plug 'scrooloose/nerdcommenter'

" Asynchroneuos build
Plug 'tpope/vim-dispatch'

" Surround with parentheses, brackets, quotes, XML tags, and more
Plug 'tpope/vim-surround'

" Better repeat
Plug 'tpope/vim-repeat'

"Switch between filetypes
Plug 'tpope/vim-projectionist'

" Different language packs
Plug 'sheerun/vim-polyglot'

"File handling
Plug 'tpope/vim-eunuch'

"Continiously updateing sessions
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'

"Snippet Plugs
Plug 'honza/vim-snippets'

" Autocompletion with Language Server Protocol
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Search for files
Plug 'junegunn/fzf.vim'

" Git support
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Statusline
Plug 'itchyny/lightline.vim'

"Indent levels
Plug 'nathanaelkane/vim-indent-guides'

" Jump between brackets with %
Plug 'vim-scripts/matchit.zip'

" Show trailing whitespaces
Plug 'bronson/vim-trailing-whitespace'

" Keymappings
Plug 'tpope/vim-unimpaired'

" Undotree
Plug 'mbbill/undotree'

" Better substitute
Plug 'tpope/vim-abolish'

call plug#end()

" Add debug support
packadd termdebug

"Projectionist config
let g:projectionist_heuristics = {
      \   '*': {
      \     '*.cpp': {
      \       'alternate': '{}.h',
      \       'type': 'source'
      \     },
      \     '*.h': {
      \       'alternate': '{}.cpp',
      \       'type': 'header'
      \     },
      \   }
      \ }

" Enable all Python syntax highlighting features
let python_highlight_all = 1

" Show line numbers
set number relativenumber

" Spellcheck
set spell spelllang=en_us

" Set tabs
set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2

" Keep cursor in the middle
set scrolloff=999

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

" Avoid swap files
set noswapfile

" Persistent undo
if has("persistent_undo")
  silent !mkdir -p ~/.cache/undodir > /dev/null 2>&1
  set undodir=~/.cache/undodir
  set undofile
endif

" Custom ultisnips config
set runtimepath+=~/.vim/mysnippets/

" Better display for messages
set cmdheight=2

" Copy and paste from clipboard
set clipboard+=unnamed

" For better searching
set hlsearch
set ignorecase

" Project specific vimrc
set exrc
set secure

" Easy split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

tnoremap <C-J> <C-W><C-J>
tnoremap <C-K> <C-W><C-K>
tnoremap <C-L> <C-W><C-L>
tnoremap <C-H> <C-W><C-H>

" Map leader key to ","
let mapleader = ","

" Search ctags file
set tags=./*tags,*tags;

" Configure fzf
set runtimepath+=~/.fzf

" Activate indent guides on startup
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" Autocompletion configuration.
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

" Remap jumplist keys
nnoremap <C-p> <C-o>
nnoremap <C-o> <C-i>

"Use tab for trigger completion with characters ahead and navigate.
let g:coc_global_extensions=["coc-python", "coc-snippets"]

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
'<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

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

" Multiple cursors
nmap <expr> <silent> <C-f> <SID>select_current_word()
function! s:select_current_word()
  if !get(g:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunc
