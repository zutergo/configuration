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

" Defines text objects 
Plug 'wellle/targets.vim'

" Better repeat
Plug 'tpope/vim-repeat'

" Different language packs
Plug 'sheerun/vim-polyglot'

"Continiously updateing sessions
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'

"Snippet Plugs
Plug 'honza/vim-snippets'

" Autocompletion with Language Server Protocol
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Search for files
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git support
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'rbong/vim-flog'

" Statusline
Plug 'itchyny/lightline.vim'

"Indent levels
Plug 'nathanaelkane/vim-indent-guides'

" Keymappings
Plug 'tpope/vim-unimpaired'

" Undotree
Plug 'mbbill/undotree'

" Better substitute
Plug 'tpope/vim-abolish'

" Practice movement
Plug 'takac/vim-hardtime'

" Automatic tabs and spaces
Plug 'tpope/vim-sleuth'

call plug#end()

" Add debug support
packadd termdebug
let g:termdebug_popup = 0
let g:termdebug_wide = 163

" Map leader key to space 
let mapleader = " "

" Show line numbers
set number relativenumber

" Set tabs
set expandtab
set tabstop=2
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

" Configure fzf
set runtimepath+=~/.fzf

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

" Search ctags file
set tags=./*tags,*tags;

" Activate indent guides on startup
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" Autocompletion configuration.

"Use tab for trigger completion with characters ahead and navigate.
let g:coc_global_extensions=["coc-python", "coc-java", "coc-snippets", "coc-clangd", "coc-cmake", "coc-yank", "coc-sh", "coc-spell-checker", "coc-xml"]

" Bash languageserver
call coc#config('languageserver', {
    \ 'bash': {
    \  "command": "bash-language-server",
    \  "args": ["start"],
    \  "filetypes": ["sh"],
    \ "ignoredRootPaths": ["~"]
    \ }
  	\ })

" Clangd mappings
nnoremap <leader>s :CocCommand clangd.switchSourceHeader<CR>

" Multiple cursors
nmap <expr> <silent> <C-f> <SID>select_current_word()
function! s:select_current_word()
  if !get(g:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunc

" Coc Yank List
nnoremap <silent> <leader>y  :<C-u>CocList -A --normal yank<cr>

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
autocmd BufWritePre *.h,*.hpp,*.c,*.cpp :call CocAction('format')


augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
