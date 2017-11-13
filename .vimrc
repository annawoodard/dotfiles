" ========== setup

set nocompatible
if v:version < 702 || (v:version == 702 && !has('patch51'))
  filetype plugin indent on

  execute pathogen#infect()
  execute pathogen#helptags()
else
  set runtimepath+=~/.vim/bundles/repos/github.com/Shougo/dein.vim

  if dein#load_state('~/.vim/bundles')
    call dein#begin('~/.vim/bundles')
    call dein#add('~/.vim/bundles/repos/github.com/Shougo/dein.vim')
    call dein#add('LaTeX-Box-Team/LaTeX-Box')
    call dein#add('airblade/vim-gitgutter')
    call dein#add('bling/vim-airline')
    call dein#add('godlygeek/tabular')
    call dein#add('majutsushi/tagbar')
    call dein#add('tpope/vim-commentary')
    call dein#add('tpope/vim-obsession')
    call dein#add('tpope/vim-fugitive')
    call dein#add('ntpeters/vim-better-whitespace')
    call dein#add('JulesWang/css.vim')
    call dein#add('avakhov/vim-yaml')
    call dein#add('mbbill/undotree')
    call dein#add('lervag/vimtex')
    call dein#add('junegunn/fzf', {'build': './install --all', 'rtp': '~/.fzf'})
    call dein#add('junegunn/fzf.vim')
    call dein#add('mhartington/oceanic-next')
    call dein#end()
    call dein#save_state()
  endif
  if has('nvim')
    if has('python3')
      call dein#add('python-mode/python-mode')
      call dein#add('davidhalter/jedi-vim')
      call dein#add('andviro/flake8-vim')
    endif
  else
    call dein#add('jlund3/colorschemer')
  endif
  filetype plugin indent on
  syntax enable

  if dein#check_install()
    call dein#install()
  endif
endif

if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" ========== general

if has('persistent_undo') " save undo tree after exit (available from vim 7.3)
  set undofile
  set undodir=~/.vim/undo
end

set history=100
set undolevels=200
set visualbell
set noerrorbells
set nobackup
set noswapfile
set autoread " reload files changed outside of vim
set backspace=indent,eol,start
set hidden " don't warn when switching buffers without saving
" set foldmethod=indent

" ========== theme
if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  if (has("termguicolors"))
    set termguicolors
  endif
else
  set t_Co=256
  if (has("termguicolors"))
    set termguicolors
  endif
endif
colorscheme OceanicNext
let g:airline_theme='oceanicnext'

" ========== display

set ruler " show the cursor position all the time
set showcmd " shows when the leader key is active in the bottom right hand corner
set laststatus=2 " always show the status line
set relativenumber
set number " show absolute line number at the line you're on
" colorscheme lucid
" set background=dark
set list
" set listchars=tab:>.,trail:.,extends:#,nbsp:.
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

" ========== folding

set foldenable
set foldlevelstart=2
set foldnestmax=10

" ========== formatting

set textwidth=72
set formatoptions=tcqorn
set smarttab
" set smartindent
set nolist
set nowrap
filetype indent on

" only do this part when compiled with support for autocommands
if has("autocmd")
  filetype plugin indent on " enable filetype detection
  set omnifunc=syntaxcomplete#Complete
  set modeline

  set sw=2
  autocmd BufRead,BufWritePre *.sh normal gg=G
  autocmd FileType C setlocal ts=2 sw=2 expandtab
  autocmd FileType cpp setlocal commentstring=//%s
  autocmd FileType python setlocal ts=4 sw=4 tw=120 expandtab omnifunc=jedi#completions
  autocmd FileType ruby setlocal ts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sw=2 expandtab
  autocmd FileType tex  setlocal ts=2 sw=2 expandtab tw=80
  autocmd FileType text setlocal textwidth=80 expandtab
  autocmd FileType sh setlocal ts=10 sw=2 expandtab
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
endif " has("autocmd")

" highlight long lines
" I still won't fix them, but at least I'll feel guilty
augroup vimrc_autocmds
  autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
  autocmd BufEnter * match OverLength /\%120v.*/
augroup END

" ========== pymode
let g:pymode_rope_goto_definition_bind='<leader>d'
let g:pymode_lint_options_pep8={'max_line_length': 120}
let g:pymode_rope_lookup_project=0
let g:pymode_rope_completion=0

" ========== flake8-vim
let g:PyFlakeCheckers = 'pep8'
let g:PyFlakeCWindow = 6 " default height of quick fix window
let g:PyFlakeSigns = 1 " place signs in the sign gutter or not
let g:PyFlakeSignStart = 1 " column of sign gutter to use-- tweaked to play nicely with GitGutter
let g:PyFlakeAggressive = 3 " aggressiveness for autopep8
let g:PyFlakeOnWrite = 0 " auto-check file for errors on write

" ========== vimtext
let g:vimtex_complete_enabled=1
let g:vimtex_complete_close_braces=1
let g:vimtex_indent_enabled=1
let g:vimtex_indent_bib_enabled=1
let g:vimtex_indent_on_ampersands=1

" ========== misc mapping
let mapleader=" "
nnoremap ; :
" nmap <S-Enter> O<Esc>
" nmap <CR> o<Esc>
inoremap jk <ESC>
vmap Q gq
nmap Q gqap
nmap <leader>gs <Plug>GitGutterStageHunk
nmap <leader>gu <Plug>GitGutterUndoHunk
nmap <leader>gn <Plug>GitGutterNextHunk
nmap <leader>gp <Plug>GitGutterPrevHunk
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
