" vim-plug
call plug#begin('~/.vim/plugged')
" Make sure you use single quotes

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'https://github.com/majutsushi/tagbar'
Plug 'https://github.com/qpkorr/vim-bufkill'
Plug 'https://github.com/nathanaelkane/vim-command-w'
Plug 'https://github.com/kien/ctrlp.vim'
Plug 'https://github.com/ivalkeen/vim-ctrlp-tjump'
Plug 'https://github.com/FelikZ/ctrlp-py-matcher'
Plug 'https://github.com/tomtom/tlib_vim'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/godlygeek/tabular'
Plug 'https://github.com/MarcWeber/vim-addon-mw-utils'
" Plug 'https://github.com/garbas/vim-snipmate'
" Plug 'https://github.com/SirVer/ultisnips'
Plug 'https://github.com/honza/vim-snippets'
Plug 'https://github.com/tomtom/quickfixsigns_vim'
Plug 'https://github.com/vim-scripts/CursorLineCurrentWindow'
Plug 'https://github.com/ConradIrwin/vim-bracketed-paste'
Plug 'https://github.com/ap/vim-buftabline'
Plug 'https://github.com/rhysd/clever-f.vim'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/gregsexton/gitv'
Plug 'https://github.com/tmhedberg/matchit'
Plug 'https://github.com/goldfeld/vim-seek'
Plug 'https://github.com/millermedeiros/vim-statline'
Plug 'https://github.com/kshenoy/vim-signature'
Plug 'https://github.com/LaTeX-Box-Team/LaTeX-Box'
Plug 'https://github.com/vimwiki/vimwiki.git'
Plug 'https://github.com/jremmen/vim-ripgrep'
" Plug 'https://github.com/rking/ag.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ajh17/VimCompletesMe'
Plug 'https://github.com/jszakmeister/markdown2ctags'
Plug 'https://github.com/inkarkat/vim-mark'
Plug 'https://github.com/inkarkat/vim-ingo-library'
Plug 'https://github.com/vim-scripts/icalendar.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'jaxbot/semantic-highlight.vim' " Semantic Highlighting
Plug 'Eliot00/git-lens.vim'



" On-demand loading
Plug 'https://github.com/scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'https://github.com/d0c-s4vage/pct-vim', { 'on': 'PctInit' }

Plug 'https://github.com/vim-php/phpctags', { 'for': 'php' }
Plug 'https://github.com/tpope/vim-markdown', { 'for': 'markdown' }
Plug 'https://github.com/fatih/vim-go', { 'for': 'go' }
Plug 'https://github.com/leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'https://github.com/neowit/vim-force.com', { 'for': 'apexcode' }
Plug 'https://github.com/rust-lang/rust.vim', { 'for': 'rust' }
Plug 'https://github.com/udalov/kotlin-vim', { 'for': 'kotlin' }

" Initialize plugin system
call plug#end()

" vimrc
source ~/.vim/vimrc.vim
