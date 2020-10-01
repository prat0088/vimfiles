set t_Co=256
set nocompatible
filetype plugin indent on
set foldenable
set foldlevelstart=99 " Don't collapse folds when opening a file
syntax on
set showmatch " Flash matching parens and brackets.
set visualbell " Flash, don't beep
set laststatus=2 " Always display the status bar
set ruler
set rulerformat=%40(%t%y:\ %l,%c%V\ \(%o\)\ %p%%%)
set number " Show line numbers in the gutter.
set numberwidth=4
set history=50 " Use history
set guioptions-=T " No toolbar
" Set our tabs correctly... tab inserts 4 spaces.
set expandtab
set sts=4
set shiftwidth=4
set smartindent
set incsearch
set hlsearch " Highlight search matches
set ignorecase
set backspace=indent,eol,start
set hidden " Don't prevent navigating away from unsaved buffers
set wildmenu " Display all wildcard matches when :e filena*<tab>-ing
set undolevels=100

set statusline=[%n]\ %{ModifiedFlag()}%f\ %=%h%r%w\ (%v,%l)\ %P\ 
function ModifiedFlag()
  if (&modified)   " if condition starts here
    return "*"
  else
    return " "
  endif           "condition if ends here
endfunction

"
" POST-IT MODE
"

function OnPostItMode()
    " Vim doesn't associate *.md with markdown mode by default. 
    set filetype=postit

    " Needed to get vim working with markdown, otherwise plasticboy's markdown
    " plugin inserts indents when hitting enter to continue a list.
    filetype plugin indent off 

    set spell spelllang=en_us

    if has("mac")
        " TODO
    else
        set guifont=DejaVu_Sans_Mono:h10:cANSI
    endif

    set nonumber
    set guioptions-=m " No menu bar
    set guioptions-=r " No scroll bar
    set laststatus=0
    set noruler
    set cursorline

    colorscheme gruvbox " Yellow, like a Post-It.
endfunction

"
" CUSTOM MAPPINGS
"

let mapleader=";"

" ALT+n/p for next/previous buffer.
nnoremap <A-j> :bnext<CR>
nnoremap <A-k> :bprevious<CR>

" CTRL+h/j/k/l for moving between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" <Leader>tn - Toggle Nerdtree
noremap <Leader>tn :NERDTreeToggle<CR>
" <Leader>mf Markdown Focus mode.  Folds everything but the current section
noremap <Leader>mf zMzv

" ALT+J/K to move current line up and down
" Mac
" http://vim.wikia.com/wiki/Moving_lines_up_or_down
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv
" Windows
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Copy/paste from/to Windows clipboard 
vmap <leader>c "+y 
nmap <leader>v "+gP

" run DocToc on current file.
nnoremap <leader>dt :!doctoc --maxlevel 3 "%"<CR>
nnoremap <leader>pi :call OnPostItMode()<CR>

"
" CUSTOM FUNCTIONS
"

function LoadCommandCenterView()
    :NERDTree ~/Documents/Command\ Center
    :cd ~/Documents/Command\ Center
endfunction

function ConfigureVoomTreeBuffer()
    :set nonumber
endfunction

function OnMarkdownFile()
    " Vim doesn't associate *.md with markdown mode by default. 
    set filetype=markdown

    " Needed to get vim working with markdown, otherwise plasticboy's markdown
    " plugin inserts indents when hitting enter to continue a list.
    filetype plugin indent off 

    set spell spelllang=en_us

    if has("mac")
        " TODO
    else
        set guifont=DejaVu_Sans_Mono:h8:cANSI
    endif

    Voom markdown
endfunction


"
" CUSTOM FILE BEHAVIOR
"

autocmd BufNewFile,BufRead *.md :call OnMarkdownFile() 

autocmd FileType voomtree :call ConfigureVoomTreeBuffer()

"
" PLUGIN CONFIG 
"

" Markdown Folding
let g:markdown_fold_style = 'nested' " Fold Markdown like a tree

" NERDTree
let NERDTreeShowBookmarks=1

" Forgot why we need this
let g:voom_ft_modes = {'markdown': 'markdown', 'mkd': 'markdown'}

" minibufexpl.vim configuration
let g:miniBufExplMapWindowNavVim=1
let g:miniBufExplSplitBelow=0
let g:miniBufExplMapWindowNavArrows=1
let g:miniBufExplMapCTabSwitchBufs=1
let g:miniBufExplModSelTarget=1
let g:miniBufExplSplitToEdge=1

" Load all of our plugins
execute pathogen#infect()

if has("mac")
    " Home colorscheme
    colorscheme lucius 
    set bg=dark
else
    " Work colorscheme
    colorscheme seoul256
    set bg=light
endif

