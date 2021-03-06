" enable filetype detection
filetype on
filetype plugin on
filetype indent on

" Indent options
set autoindent " New lines inherit the indentation of previous lines.
set tabstop=2 " Indent using two spaces.
set expandtab " Convert tabs to spaces.
set shiftwidth=2 " When shifting, indent using two spaces.
set shiftround " When shifting lines, round the indentation to the nearest multiple of “shiftwidth.”
set smarttab " Insert “tabstop” number of spaces when the “tab” key is pressed.
set nowrap


" support tab for makefile
au Filetype make setlocal noexpandtab nosmarttab tabstop=8 shiftwidth=8
" do not copy comment symbol to the next line
au Filetype * set fo-=c fo-=r fo-=o
" git commit support
au Filetype gitcommit setlocal textwidth=72 colorcolumn=+1
" set wrap for Markdown or tex
au Filetype Markdown setlocal wrap 
au Filetype *tex setlocal wrap


" ---------------------------------------------------------------------------
" python indent option (used in ~/.vim/after/ftplugin/python.vim)
"
" setlocal indentexpr=GetGooglePythonIndent(v:lnum)
"
" let s:maxoff = 50 " maximum number of lines to look backwards.
" function GetGooglePythonIndent(lnum)
"   " Indent inside parens.
"   " Align with the open paren unless it is at the end of the line.
"   " E.g.
"   " open_paren_not_at_EOL(100,
"   "                       (200,
"   "                        300),
"   "                       400)
"   " open_paren_at_EOL(
"   "     100, 200, 300, 400)
"   call cursor(a:lnum, 1)
"   let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
"         \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
"         \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
"         \ . " =~ '\\(Comment\\|String\\)$'")
"   if par_line > 0
"     call cursor(par_line, 1)
"     if par_col != col("$") - 1
"       return par_col
"     else
"       return indent(par_line) + &sw  " FIXED FROM ORIGINAL SCRIPT
"     endif
"   endif
"
"   " Delegate the rest to the original function.
"   " return GetPythonIndent(a:lnum)
"
" endfunction
"
" let pyindent_nested_paren="&sw*2"
" let pyindent_open_paren="&sw*2"
" ---------------------------------------------------------------------------

" Search options
set hlsearch " Highlight searched keyword
nnoremap i :noh<cr>i
nnoremap o :noh<cr>o
nnoremap O :noh<cr>O
set incsearch " Incremental search that shows partial matches.
set ignorecase " Automatically switch search to case-sensitive when search query contains an uppercase letter.

" Performance options
set complete-=i " Limit the files searched for auto-completes.
set lazyredraw " Don’t update screen during macro and script execution.

" Text rendering options
set display+=lastline " Always try to show a paragraph’s last line.
set fileencodings=utf-8 " Set file encoding
syntax enable

" UI options
set laststatus=2 " Always display the status bar.
set ruler " Always show cursor position.
set wildmenu " Display command line’s tab complete options as a menu.
set tabpagemax=50 " Maximum number of tab pages that can be opened from the command line.
set number " Show line number
set noerrorbells " Disable beep on errors.
set title " Set the window’s title, reflecting the file currently being edited.

" Only for unix users.
set mouse=a " Enable mouse for scrolling and resizing.
set backspace=indent,eol,start

" Miscellaneous Options
set autoread " Automatically re-read files if unmodified inside Vim.
set history=500 " Increase undo history
set encoding=utf-8 " The encoding displayed.
set fileencoding=utf-8 " The encoding written to file.

" Auto install plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" UI plugins
Plug 'preservim/nerdtree'

" Color themes
"Plug 'doums/darcula'
Plug 'morhetz/gruvbox'

" Lightline settings
Plug 'itchyny/lightline.vim'

" Doxygen automation
Plug 'vim-scripts/DoxygenToolkit.vim'

" YCM (Optional)
Plug 'valloric/youcompleteme'

" Tagbar - class explanation
Plug 'preservim/tagbar'

" Initialize plugin system
call plug#end()

" Color scheme settings

set t_Co=256
colo gruvbox
"set termguicolors
set background=dark
" TODO: Find a way to prevent syntax highlighting from being disabled over color-column.
highlight ColorColumn guibg=#2d2d2d 
let &colorcolumn="".join(range(100, 999),",")

" Nerdtree settings
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

" Lightline settings
set noshowmode
let g:lightline = { 'colorscheme': 'jellybeans' }

" Tagbar settings
" Press F8 to toggle tagbar
nmap <F8> :TagbarToggle<CR>
" TODO : currently have some issue using mouse on Tagbar screen

" save last cursor position
au BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \ exe "norm g`\"" |
      \ endif

