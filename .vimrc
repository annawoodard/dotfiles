 " ========== setup

if v:version < 702 || (v:version == 702 && !has('patch51'))
   set nocompatible
   filetype plugin indent on

   execute pathogen#infect()
   execute pathogen#helptags()
 else
   if has('vim_starting')
     set nocompatible
     set runtimepath+=~/.vim/bundle/neobundle.vim/
     " set runtimepath^=~/.vim/bundle/ctrlp.vim
   endif

   call neobundle#begin(expand('~/.vim/bundle/'))

   NeoBundleFetch 'Shougo/neobundle.vim'

   " NeoBundle 'LaTeX-Box-Team/LaTeX-Box'
   NeoBundle 'airblade/vim-gitgutter'
   NeoBundle 'altercation/vim-colors-solarized'
   NeoBundle 'jlund3/colorschemer'
   NeoBundle 'bling/vim-airline'
   " NeoBundle 'godlygeek/tabular'
   " NeoBundle 'majutsushi/tagbar'
   NeoBundle 'tpope/vim-commentary'
   NeoBundle 'tpope/vim-obsession'
   " NeoBundle 'tpope/vim-fugitive'
   NeoBundle 'ntpeters/vim-better-whitespace'
   " NeoBundle 'JulesWang/css.vim'
   NeoBundle 'avakhov/vim-yaml'
   " NeoBundle 'mbbill/undotree'
   " NeoBundle 'vim-scripts/taglist.vim'
   NeoBundle 'rking/ag.vim'
   " NeoBundle 'klen/python-mode'
   NeoBundle 'andviro/flake8-vim'
   NeoBundle 'lervag/vimtex'
   call neobundle#end()

   filetype plugin indent on

   NeoBundleCheck
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
 let g:ag_prg="ag --column"
 set hidden " don't warn when switching buffers without saving
 " set foldmethod=indent

  " ========== display

 set ruler " show the cursor position all the time
 set showcmd " shows when the leader key is active in the bottom right hand corner
 set laststatus=2 " always show the status line
 set relativenumber
 set number " show absolute line number at the line you're on
 colorscheme lucid
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
 set wildignore=*.aux,*.dvi,*.fmt,*.log,*.nav,*.out,*.snm,*.toc,*.pyc

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

   autocmd BufRead,BufWritePre *.sh normal gg=G
   autocmd FileType C setlocal ts=2 sw=2 expandtab
   autocmd FileType cpp setlocal commentstring=//%s
   autocmd FileType python setlocal ts=4 sw=4 tw=120 expandtab
   autocmd FileType ruby setlocal ts=2 sw=2 expandtab
   autocmd FileType css setlocal ts=2 sw=2 expandtab
   " autocmd FileType tex  setlocal ts=2 sw=2 expandtab tw=70 formatoptions+=t iskeyword+=:
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

 " ========== ctrl-p (amazing fuzzy file, etc. finder)
 let g:ctrlp_map = '<c-o>'
 let g:ctrlp_cmd = 'CtrlP'
 let g:ctrlp_mruf_case_sensitive = 0

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

 " ========== misc mapping

 let mapleader=" "
 nnoremap ; :
 " nmap <S-Enter> O<Esc>
 " nmap <CR> o<Esc>
 inoremap jk <ESC>
 vmap Q gq
 nmap Q gqap
 nmap <leader>gs <Plug>GitGutterStageHunk
 nmap <leader>gr <Plug>GitGutterRevertHunk
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
