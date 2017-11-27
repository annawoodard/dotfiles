" ========== setup
set t_BE=
if &compatible
  set nocompatible
endif

if v:version < 702 || (v:version == 702 && !has('patch51'))
  execute pathogen#infect()
  execute pathogen#helptags()
else
  set runtimepath+=~/.vim/bundles/repos/github.com/Shougo/dein.vim
  let g:dein#types#git#default_protocol='ssh'

  if dein#load_state('~/.vim/bundles')
    call dein#begin('~/.vim/bundles')
    call dein#add('~/.vim/bundles/repos/github.com/Shougo/dein.vim')
    call dein#add('airblade/vim-gitgutter')
    call dein#add('bling/vim-airline')
    call dein#add('godlygeek/tabular')
    call dein#add('ervandew/supertab')
    call dein#add('majutsushi/tagbar')
    call dein#add('tpope/vim-commentary')
    call dein#add('tpope/vim-obsession')
    call dein#add('tpope/vim-surround')
    call dein#add('tpope/vim-repeat')
    call dein#add('tpope/vim-fugitive', {'on_cmd': ['Git', 'Gstatus', 'Gwrite', 'Glog', 'Gcommit', 'Gblame', 'Ggrep', 'Gdiff'] })
    call dein#add('ntpeters/vim-better-whitespace')
    call dein#add('JulesWang/css.vim', {'on_ft': 'css'})
    call dein#add('avakhov/vim-yaml', {'on_ft': 'yaml'})
    call dein#add('mbbill/undotree')
    call dein#add('lervag/vimtex', {'on_ft': 'tex'})
    call dein#add('junegunn/fzf', {'build': './install --all', 'rtp': '~/.fzf'})
    call dein#add('junegunn/fzf.vim')
    call dein#add('mhartington/oceanic-next')
    if has('nvim')
      call dein#add('prabirshrestha/asyncomplete.vim')
      call dein#add('prabirshrestha/asyncomplete-lsp.vim')
      call dein#add('prabirshrestha/async.vim')
      call dein#add('prabirshrestha/vim-lsp')
      call dein#add('w0rp/ale')
    endif
    call dein#end()
    call dein#save_state()
  endif
  if dein#check_install()
    call dein#install()
  endif
endif

" ========== general

let mapleader=" "
set history=100
set undolevels=200
set visualbell
set noerrorbells
set nobackup
set noswapfile
set autoread " reload files changed outside of vim
set hidden " don't warn when switching buffers without saving
set autowriteall
if has('persistent_undo') " save undo tree after exit (available from vim 7.3)
  set undofile
  set undodir=~/.vim/undo
end

" ========== theme

if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
else
  set t_Co=256
endif
if (has("termguicolors"))
  set termguicolors
endif
colorscheme OceanicNext
let g:airline_theme='oceanicnext'

" ========== display

set ruler " show the cursor position all the time
set showcmd " shows when the leader key is active in the bottom right hand corner
set laststatus=2 " always show the status line
set relativenumber
set number " show absolute line number at the line you're on
set list
set listchars=tab:▸\ ,eol:¬
let Tlist_Auto_Open=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" ========== automatic completion

set wildmenu " enable enhanced mode for command-line completion
set wildmode=list:longest,full " list all matches and complete each full match
set wildignore=*.aux,*.dvi,*.fmt,*.log,*.nav,*.out,*.snm,*.toc,*.pyc,*/.git/*,*.swp

" ========== search

set incsearch
set ignorecase
set smartcase

if executable("rg")
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" ========== folding

set foldenable
set foldlevelstart=2
set foldnestmax=10

" ========== formatting

set textwidth=72
set formatoptions=tcqorn
set smarttab
set nolist
set nowrap
filetype indent on

" only do this part when compiled with support for autocommands
if has("autocmd")
  filetype plugin indent on " enable filetype detection
  set omnifunc=syntaxcomplete#Complete
  set modeline

  autocmd FileType C setlocal ts=2 sw=2 expandtab
  autocmd FileType cpp setlocal commentstring=//%s
  autocmd FileType python setlocal ts=4 sw=4 tw=120 expandtab
  autocmd FileType ruby setlocal ts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sw=2 expandtab
  autocmd FileType tex,plaintex  setlocal ts=2 sw=2 expandtab tw=80 spell spelllang=en_us
  autocmd FileType text setlocal textwidth=80 expandtab spell spelllang=en_us
  autocmd FileType sh setlocal ts=4 sw=2 expandtab
  autocmd BufNewFile,BufRead */CMSSW*{cc,h} setlocal ts=3 sw=3 expandtab
  autocmd BufNewFile,BufRead */CMSSW* setlocal makeprg=scram\ b
  autocmd VimEnter * Obsess .session.vim

  syntax on

  " always jump to the last known cursor position,
  " unless position is invalid or inside an event handler
  autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\   exe "normal g`\"" |
	\ endif
else
  set autoindent
endif

" highlight long lines
" I still won't fix them, but at least I'll feel guilty
augroup vimrc_autocmds
  autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
  autocmd BufEnter * match OverLength /\%120v.*/
augroup END

" ========== python

if executable('pyls')
  au User lsp_setup call lsp#register_server({
	\ 'name': 'pyls',
	\ 'cmd': {server_info->['pyls']},
	\ 'whitelist': ['python'],
	\ })
  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
  autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
endif

if has('nvim')
  let g:ale_fixers = {'python': ['autopep8', 'yapf', 'isort', 'trim_whitespace', 'remove_trailing_lines']}
endif

" ========== vimtext

let g:tex_flavor='latex'
let g:vimtex_complete_enabled=1
let g:vimtex_complete_close_braces=1
let g:vimtex_indent_enabled=1
let g:vimtex_indent_bib_enabled=1
let g:vimtex_indent_on_ampersands=1

" ========== misc mapping

inoremap jk <ESC>
nmap <leader>gs <Plug>GitGutterStageHunk
nmap <leader>gu <Plug>GitGutterUndoHunk
nmap <leader>gn <Plug>GitGutterNextHunk
silent! call repeat#set("\<Plug>GitGutterNextHunk", v:count)
nmap <leader>gp <Plug>GitGutterPrevHunk
silent! call repeat#set("\<Plug>GitGutterPrevHunk", v:count)
nmap <leader>p  <Plug>(ale_previous_wrap)
silent! call repeat#set("\<Plug>(ale_previous_wrap)", v:count)
nmap <leader>n  <Plug>(ale_next_wrap)
silent! call repeat#set("\<Plug>(ale_next_wrap)", v:count)
nnoremap <leader>u :UndotreeToggle<cr>
map <leader>l :bn<cr>
map <leader>h :bp<cr>
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nmap <leader>, :nohlsearch<CR> " clear the search buffer
cmap w!! w !sudo tee % >/dev/null " write when sudo is required after opening
noremap <leader>W :%s/\s+$//<cr>:let @/=''<CR> " kill trailing whitespace
nnoremap <leader>o :Files<cr>
