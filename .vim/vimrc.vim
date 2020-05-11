" Keymappings {{{
" Use , in addition to \ for the leader
let mapleader = ","
map \ ,
" save my pinky
nore ; :
" auto-format the current paragraph
nnoremap __ gwip
nnoremap -- :call WrapMerge()<CR>
" correct spelling
nmap <F1> [s1z=<C-o>
imap <F1> <Esc>[s1z=<C-o>a
" file explorer
"map <silent> <F9> :call ToggleVExplorer()<CR>
map <silent> <F9> :NERDTreeToggle<CR>
" tagbar
nnoremap <silent> <F10> :call Min_width_tagbar()<CR>
" paste mode
set pastetoggle=<F11>
" preview the tag under the cursor
nmap <C-p> :exe "ptag" expand("<cword>")<CR>
nnoremap <silent> <C-c> :QFix<cr>
" Window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" Keep selected blocks selected when shifting
vmap > >gv
vmap < <gv
" Base64 conversion
vnoremap <leader>64 c<c-r>=system('base64',@")<cr><esc>
vnoremap <leader>64d c<c-r>=system('base64 --decode',@")<cr><esc>
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>
" Treat long lines as break lines (useful when moving around in them)
" map j gj
" map k gk
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>
" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen
  set stal=2
catch
endtry
" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
" :W sudo saves the file (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null
" Bash like keys for the command line
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>
" Ctrl-backspace to delete a word
imap  <C-w>
imap <C-BS> <C-w>
" Ctrl-s for saving when in gVIM
if has("gui_running")
    imap <C-s> <C-o>:update<CR>
    map <C-s> :update<CR>
endif
" Ack
" nnoremap _lg :call TAckRun(" ", "normal")<CR>
" nnoremap _lG :call TAckRun("-i ", "normal")<CR>
" vnoremap _lg :call TAckRun(" ", "visual")<CR>
" vnoremap _lG :call TAckRun("-i ", "visual")<CR>
" CTRL-v in insert mode inserts * register without indent correction
imap <C-v> <C-r><C-o>*
"Select All
map <C-a> ggVG
" ctrl-PgUp/PgDn to switch buffers in normal mode
map [5;5~ :bn<cr>
map [6;5~ :bp<cr>
map <C-PageUp> :bn<cr>
map <C-PageDown> :bp<cr>
noremap <D-{> :bp<CR>
noremap <D-}> :bn<CR>
inoremap <D-{> <ESC>:bp<CR>
inoremap <D-}> <ESC>:bn<CR>
" CommandW to kill buffers
if has("gui_macvim")
    macmenu &File.Close key=<nop>
    nmap <D-w> :CommandW<CR>
    imap <D-w> <Esc>:CommandW<CR>
endif
" Let me choose the ctag
nnoremap <C-]> :execute 'tj' expand('<cword>')<CR>zv
" Old Mark mapping is preferable to new one
nmap <unique> <F8> <Plug>MarkSet
xmap <unique> <F8> <Plug>MarkSet
" Home insert-mode escape
inoremap kj <esc>
" }}}

" Settings {{{
set history=500         " Sets how many lines of history VIM has to remember
set autoread            " Set to auto read when a file is changed from the outside
syntax on
filetype plugin on
filetype indent on

if has('gui')
    set gcr=n:blinkon0       " don't blink the cursor in normal mode
    set guioptions=giM       " get rid of useless stuff in the gui
    set clipboard=unnamed
    if has("gui_macvim")
        set guifont=Inconsolata:h15
        noremap <Leader>zo :set guifont=Inconsolata:h8<CR>
        noremap <Leader>zi :set guifont=Inconsolata:h20<CR>
    else
        set guifont=Inconsolata\ 14
    endif
endif
if has('gui_running')
    set ballooneval
    set balloondelay=100
endif

set mouse=a                 " Turn this off for console-only mode
set selectmode-=mouse       " Allow the mouse to enter visual mode
set cursorline              " Highlight current line, but slow
set foldlevelstart=20       " I don't like folding when I open a document
set cmdheight=1             " Height of the command bar
set et                      " expand tabs
set diffopt+=iwhite,vertical,filler   " ignore whitespace in diffs
set hidden                  " allow hidden buffers
set noerrorbells vb t_vb=   " no bells
set nu                      " line numbers
set viewdir=$HOME/.views    " keep view states out of my .vim
set pumheight=15            " trim down the completion popup menu
set shortmess+=atIoT        " save space in status messages
set scrolloff=3             " 3 lines of buffer before scrolling
set ignorecase              " case insensitive searches
set smartcase               " unless you type uppercase explicitly
set smarttab                " use shiftwidth instead of tab stops
set wildmode=longest,list,full   " shows a list of candidates when tab-completing
set wildmenu                " use a more functional completion menu when tab-completing
" Avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en
set encoding=utf-8          " always use utf-8
set hlsearch                " highlight all search matches
set foldcolumn=0            " I never use this.
set nojoinspaces            " disallow two spaces after a period when joining
if version >= 704
    set formatoptions=qjntlmnc " auto-formatting style
else
    set formatoptions=qntlmnc  " auto-formatting style minus j
endif
set autoindent
set shiftround              " Round to the nearest shiftwidth when shifting
set textwidth=78
set linebreak               " When soft-wrapping long lines, break at a word
set wrap
set comments-=s1:/*,mb:*,ex:*/
set comments+=fb:*,b:\\item
set formatlistpat=^\\s*\\([0-9]\\+\\\|[a-z]\\)[\\].:)}]\\s\\+
set grepprg=grep\ -R\ --exclude=\"*.aux\"\ --exclude=\"tags\"\ --exclude=\"*scope.out\"\ --color=always\ -nIH\ $*
set cpoptions=BFt
set completeopt=menuone,longest
autocmd Filetype *
        \	if &omnifunc == "" |
        \		setlocal omnifunc=syntaxcomplete#Complete |
        \	endif
set tags=./tags;
set nobackup                " ugh, stop making useless crap
set nowritebackup           " same with overwriting
set noswapfile
set directory=/tmp          " litter up /tmp, not the CWD
set nomodeline              " modelines are dumb
set tabstop=4 shiftwidth=4
set backspace=indent,eol,start
set whichwrap+=<,>,h,l,[,]  " left/right cursor navigation wraps
set ruler                   " show position in file
set title
set titlestring=%t%(\ %M%)%(\ (%<%{expand(\"%:p:h:s?/Users/agrant/ncc/Projects/??:?/Users/agrant/ncc/current_project/??\")})%)%(\ %a%)
set ttimeout
set ttimeoutlen=100         " Make it so Esc enters Normal mode right away
set helpheight=0            " no minimum helpheight
set incsearch               " search incrementally
set showmatch               " show the matching terminating bracket
set suffixes=.out           " set priority for tab completion
set wildignore+=*.bak,~*,*.o,*.aux,*.dvi,*.bbl,*.blg,*.orig,*.toc,*.fls
set wildignore+=*.loc,*.gz,*.tv,*.ilg,*.lltr,*.lov,*.lstr,*.idx,*.pdf
set wildignore+=*.fdb_latexmk,*.ind,*.cg,*.tdo,*.log,*.latexmain,*.out
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif
set sidescroll=1            " soft wrap long lines
set lazyredraw ttyfast      " go fast
set errorfile=/tmp/errors.vim
set cscopequickfix=s-,c-,d-,i-,t-,e-        " omfg so much nicer
set autoread                " Disable warning about file change to writable
set conceallevel=0          " Don't hide things by default
set magic                   " vim default for regualr expressions
set noequalalways           " Do not equalize the windows when closing a split; because of Tagbar
set showcmd                 " Show the number of selected lines in visual mode

" Set 'very magic' for most places regular expressions are used
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %smagic/
cnoremap \>s/ \>smagic/
" nnoremap :g/ :g/\v
" nnoremap :g// :g//
set ffs=unix,dos,mac        " Use Unix as the standard file type

" colors
set t_Co=256                " use 256 colors
colorscheme wombat256mod
set background=dark
let g:airline_theme="wombat"

" Always show the status line
set laststatus=2
" Format the status line
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

" Open MacVim in fullscreen mode
if has("gui_macvim")
    set fuoptions=maxvert,maxhorz
endif

" Ack
" if has("mac") || has("macunix")
"     let g:ackprg="ag --nocolor --nogroup --column"
" else
"     let g:ackprg="ag --nocolor --nogroup --column"
" endif
" }}}

" Use ripgrep {{{
set grepprg=rg\ --vimgrep

let g:rg_binary = "rg"
let g:rg_command = g:rg_binary . " --vimgrep --glob=\"\!.git/*\" --glob=\"\!tags\""

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
" }}}

" Plugins

" Airline {{{
let g:airline#extensions#wordcount#enabled = 0      " Disable word count
let g:airline#extensions#whitespace#enabled = 0     " Disable whitespace warnings
let g:airline#extensions#hunks#enabled = 0          " Disable source control hunks
let g:airline#extensions#branch#enabled = 0         " Disable source control branch details
let g:airline_section_z = '%#__accent_bold#%3l%#__restore__#%#__accent_bold#/%L%#__restore__# :%2v'     " Only show: curr line / total lines : column
let g:airline_section_b = ''                        " Not using at the moment
let g:airline_section_x = ''                        " Not using at the moment
" }}}

" git gutter {{{
let g:gitgutter_enabled=0
nnoremap <silent> <leader>d :GitGutterToggle<cr>
" }}}

" Turn persistent undo on 
" means that you can undo even when you close a buffer/VIM
try
    set undodir=~/.vim/temp_dirs/undodir
    set undofile
catch
endtry


" netrw {{{
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_winsize=25
let g:netrw_banner=0
let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+' "hide files by default
let g:netrw_sort_sequence = '[\/]$,*,\%(' . join(map(split(&suffixes, ','), 'escape(v:val, ".*$~")'), '\|') . '\)[*@]\=$'
" }}}

" quickfixsigns {{{
let g:quickfixsigns_classes=['qfl', 'loc', 'marks', 'vcsdiff', 'breakpoints']
let g:quickfixsigns_echo_balloon = 1
" Disable display of the ' and . marks, so the gutter will be disabled until
" manually set marks or quickfix/diff info is present.
let g:quickfixsigns#marks#buffer = split('abcdefghijklmnopqrstuvwxyz', '\zs')
let g:quickfixsign_use_dummy = 0
" Aaaand we just found the limitations of manual fold markers
let g:quickfixsigns#vcsdiff#highlight = {'DEL': 'QuickFixSignsDiffDeleteLx', 'ADD': 'QuickFixSignsDiffAddLx', 'CHANGE': 'QuickFixSignsDiffChangeLx'}   "{{{2}}}"
" }}}

" buftabs {{{
let g:buftabs_only_basename=1
" }}}

" buftabline {{{
let g:buftabline_show=1
let g:buftabline_separators=1
" }}}

" clever-f {{{
let g:clever_f_mark_char_color="PreProc"
let g:clever_f_smart_case=1
let g:clever_f_hide_cursor_on_cmdline=0
" }}}

" cscope {{{
let g:cscope_interested_files = '\.java$\|\.php$\|\.h$\|\.hpp|\.cpp|\.c$|\.m$|\.swift$|\.py$'
let g:cscope_split_threshold = 99999
let g:cscope_auto_update = 0
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>
" s: Find this C symbol
nnoremap  <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>
" }}}

" Indentlines {{{
nmap \|\| :IndentLinesToggle<CR>
let g:indentLine_faster = 1
let g:indentLine_enabled = 0
" }}}

" Limelight {{{
let g:limelight_conceal_ctermfg = 240
let g:limelight_conceal_guifg = '#777777'
let g:limelight_default_coefficient = 0.7
" }}}

" latex-box {{{
let g:tex_flavor="latex"
let g:tex_no_error = 1
let g:tex_conceal= ""
let g:tex_comment_nospell = 1
let g:LatexBox_latexmk_options = "--disable-write18 --file-line-error --interaction=batchmode -pdflatex=lualatex -latex=lualatex"
"let g:LatexBox_latexmk_options = "-xelatex --disable-write18 --file-line-error --interaction=batchmode"
" Work around the fact that cmdline macvim doesn't support server mode
if has("gui_macvim")
    let g:LatexBox_latexmk_async = 1
else
    if has("macunix")
        let g:LatexBox_latexmk_async = 1
    else
        let g:LatexBox_latexmk_async = 0
    endif
endif
let g:LatexBox_viewer = "open"
let g:LatexBox_split_side = "rightbelow"
let g:LatexBox_quickfix = 0
let g:LatexBox_fold_automatic = 0
let g:LatexBox_show_warnings = 0
let g:LatexBox_ignore_warnings = [
            \ 'Underfull',
            \ 'Overfull',
            \ 'specifier changed to',
            \ 'Font shape',
            \ 'epstopdf',
            \ ]

let g:LatexBox_fold_parts=[
           \ "part",
           \ "chapter",
           \ "section",
           \ "subsection",
           \ "subsubsection",
           \ "vtitle"
           \ ]

augroup latex
    if &diff
        let g:LatexBox_Folding = 0
        let g:LatexBox_fold_preamble = 0
        let g:LatexBox_fold_envs = 0
    else
        let g:LatexBox_Folding = 1
        let g:LatexBox_fold_preamble = 1
        let g:LatexBox_fold_envs = 1
    endif
    au FileType tex syntax spell toplevel
    au FileType tex set spell textwidth=78 smartindent
    au FileType tex set formatoptions+=w
    au FileType tex imap <buffer> [[ \begin{
    au FileType tex imap <buffer> ]] <Plug>LatexCloseCurEnv
    au FileType tex imap <S-Enter> \pagebreak
    au FileType tex nmap tt i\texttt{<Esc>wEa}<Esc>
    au FileType tex source ~/.vim/ftplugin/quotes.vim
    " Key binding for opening input files
    au FileType tex nnoremap <buffer> gh :call OpenTexFile()<CR>
    " Function for opening input and inputvuln files
    function! OpenTexFile()
        exe "normal 0l"
        if expand("<cword>") == "inputvuln"
            exe "normal 0Eh"
            belowright wincmd f
            wincmd k
            1wincmd _
            exe "normal zz"
            wincmd j
        else
            exe "normal 0Ehgf"
        endif
    endfunction
augroup end
" }}}

" supertab {{{
" let g:SuperTabContextFileTypeExclusions = ['make']
" let g:SuperTabDefaultCompletionType = "context"
" let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
" let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
" let g:SuperTabContextDiscoverDiscovery =
"     \ ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]

" autocmd FileType *
"             \  if &omnifunc != '' |
"             \      let g:myfunc = &omnifunc |
"             \  elseif &completefunc != '' |
"             \      let g:myfunc = &completefunc |
"             \  else |
"             \      let g:myfunc = '' |
"             \  endif |
"             \  if g:myfunc != '' |
"             \      call SuperTabChain(g:myfunc, "<c-p>") |
"             \      call SuperTabSetDefaultCompletionType("<c-x><c-u>") |
"             \  endif
" }}}


" rainbow {{{
" map <Leader>r :RainbowToggle<CR>
" }}}


" CtrlP {{{
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_map = '<C-e>'
let g:ctrlp_by_filename = 1
" let g:ctrlp_working_path_mode = 0
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_max_height = 30
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_extensions = ['buffertag']
let g:ctrlp_max_files = 0
let g:ctrlp_lazy_update = 350
let g:ctrlp_root_markers = ['tags']
" let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ctrlp_tjump_shortener = ['/\(Users|home\)/agrant', '~']
let g:ctrlp_tjump_only_silent = 1
" Speed up CtrlP
let g:ctrlp_user_command = "find %s -type f | egrep -v '/\.(git|hg|svn)|solr|tmp/' | egrep -v '\.(png|exe|jpg|gif|jar|class|swp|swo|log|gitkep|keepme|so|o)$'"
let g:ctrlp_max_files=0 " No limit CtrlP
map <Leader>e :CtrlPMixed<CR>
map <Leader>m :CtrlPMRU<CR>
map <Leader>t :CtrlPTag<CR>
map <Leader>g :CtrlPBufTagAll<CR>
map <Leader>b :CtrlPBuffer<CR>
nmap <C-p> :call TogglePTag()<CR>
" CtrlP tjump
nnoremap <c-]> :CtrlPtjump<cr>
vnoremap <c-]> :CtrlPtjumpVisual<cr>
" If the preview window is open, close it; else ptag
function! TogglePTag()
    if getwinvar(winnr("#"), "&pvw") == 1
        pclose
    else
        try
            exe "ptag" expand("<cword>")
        catch
            echo "No tags found for: " . expand("<cword>")
        endtry
    endif
endfunction
" }}}


" statline {{{
let g:statline_trailing_space=0
let g:statline_mixed_indent=0
let g:statline_filename_relative=1
" }}}


" tagbar {{{
let g:tagbar_iconchars = ['▸', '▾']
let g:tagbar_type_objc = {
    \ 'ctagstype' : 'ObjectiveC',
    \ 'kinds'     : [
        \ 'i:interface',
        \ 'I:implementation',
        \ 'p:Protocol',
        \ 'm:Object_method',
        \ 'c:Class_method',
        \ 'v:Global_variable',
        \ 'F:Object field',
        \ 'f:function',
        \ 'p:property',
        \ 't:type_alias',
        \ 's:type_structure',
        \ 'e:enumeration',
        \ 'M:preprocessor_macro',
    \ ],
    \ 'sro'        : ' ',
    \ 'kind2scope' : {
        \ 'i' : 'interface',
        \ 'I' : 'implementation',
        \ 'p' : 'Protocol',
        \ 's' : 'type_structure',
        \ 'e' : 'enumeration'
    \ },
    \ 'scope2kind' : {
        \ 'interface'      : 'i',
        \ 'implementation' : 'I',
        \ 'Protocol'       : 'p',
        \ 'type_structure' : 's',
        \ 'enumeration'    : 'e'
    \ }
\ }

let g:tagbar_type_tex = {
    \ 'ctagstype' : 'latex',
    \ 'kinds'     : [
        \ 's:sections',
        \ 'g:graphics',
        \ 'l:labels',
        \ 'r:refs:1',
        \ 'p:pagerefs:1',
        \ 'v:vulns',
        \ 'r:strecs',
        \ 'R:ltrecs'
    \ ],
    \ 'sort'    : 0,
\ }

" Add support for markdown files in tagbar.
" let g:tagbar_type_markdown = {
"         \ 'ctagstype' : 'markdown',
"         \ 'kinds' : [
"                 \ 'h:Heading_L1',
"                 \ 'i:Heading_L2',
"                 \ 'j:Heading_L3',
"                 \ 'k:Heading_L4',
"                 \ 'l:Heading_L5'
"         \ ]
" \ }

" Using markdown2ctags for nesting
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '/Users/agrant/.vim/plugged/markdown2ctags/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes --sro=»',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '»',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }

let g:tagbar_type_scala = {
    \ 'ctagstype' : 'Scala',
    \ 'kinds'     : [
        \ 'p:packages:1',
        \ 'V:values',
        \ 'v:variables',
        \ 'T:types',
        \ 't:traits',
        \ 'o:objects',
        \ 'a:aclasses',
        \ 'c:classes',
        \ 'r:cclasses',
        \ 'm:methods'
    \ ]
\ }
" }}}

" augroups {{{
augroup cjava
    au!
    au BufNewFile *.c r ~/..vim/templates/template.c
    au BufWinEnter *.[mCchly] set nospell number comments+=s1:/*,mb:*,ex:*/
    au BufWinEnter,BufNewFile *.m,*.xm,*.xmi setfiletype objc
    au BufWinEnter,BufNewFile *.m,*.xm,*.xmi let c_no_curly_error = 1
    au BufWinEnter *.cpp,*.java set nospell number
    au BufWinLeave *.[mchly] mkview
    au BufWinEnter *.[mchly] silent loadview
    au BufWinLeave *.cpp,*.java mkview
    au BufWinEnter *.cpp,*.java silent loadview
augroup end

augroup html
    au!
    au FileType html set spell wrapmargin=5 wrapscan number
    au FileType html set wrapscan&
    au BufNewFile *.html r ~/.vim/templates/template.html
    au BufWinLeave *.htm* mkview
    au BufWinEnter *.htm* silent loadview
augroup end

augroup python
    au FileType python set smartindent smarttab nospell number
    au BufWinLeave *.py mkview
    au BufWinEnter *.py silent loadview
augroup end

augroup php
    au FileType php set smartindent smarttab nospell number
    au BufWinLeave *.php mkview
    au BufWinEnter *.php silent loadview
    " Hide PHP variables in Tagbar
    let g:tagbar_type_php  = {
        \ 'ctagstype' : 'php',
        \ 'kinds'     : [
            \ 'i:interfaces',
            \ 'c:classes',
            \ 'd:constant definitions',
            \ 'f:functions',
            \ 'j:javascript functions:1'
        \ ]
    \ }
    " PHP Tagbar
    let g:tagbar_phpctags_bin='/usr/local/bin/phpctags'
augroup end

augroup markdown
    au BufWinEnter *.notes set filetype=markdown
    au BufWinLeave *.md,*.notes, mkview
    au BufWinEnter *.md,*.notes, silent loadview
    au BufWinEnter *.md,*.notes, imap <C-l> <C-t>
    au BufWinEnter *.md,*.notes, imap <C-h> <C-d>
    au BufWinEnter *.md,*.notes,*mutt*,*.wiki imap >> <C-t>
    au BufWinEnter *.md,*.notes,*mutt*,*.wiki imap << <C-d>
    au FileType markdown set spell
    au FileType markdown set textwidth=78 complete+=k comments+=b:-,b:+,b:*,b:+,n:>
augroup end

" Disable spellcheck on quickfix, switch between quickfix lists with the arrow
" keys
augroup quickfix
    au FileType qf, noremap ' <CR><C-W><C-P>j
    au FileType qf, set nospell number
    au FileType qf, nnoremap <silent> <buffer> <right> :cnew<CR>
    au FileType qf, nnoremap <silent> <buffer> <left> :col<CR>
    au FileType qf, setlocal statusline=\ %n\ \ %f%=L%l/%L\ %P
    au BufReadPost quickfix call GrepColors()
    au BufWinEnter quickfix call GrepColors()
    au BufWinEnter qf:list call GrepColors()
augroup end

augroup msdocs
    au BufReadCmd *.docx,*.xlsx,*.pptx call zip#Browse(expand("<amatch>"))
    au BufReadCmd *.odt,*.ott,*.ods,*.ots,*.odp,*.otp,*.odg,*.otg call zip#Browse(expand("<amatch>"))
augroup end

augroup misc
    au FileType netrw silent! unmap <buffer> --
    au BufWinEnter *.applescript set filetype=applescript
    au BufWinEnter *.nmap, set syntax=nmap
    au BufWinEnter *.scala, set filetype=scala
    au BufWinEnter *.proto, set filetype=proto
    au BufWinEnter *.dtrace, set filetype=D
    au BufWinEnter *.less, set filetype=css
    au BufWinEnter *.fugitiveblame,*.diff, set nospell number
    au BufWinLeave *.txt,*.conf,.vimrc,*.notes mkview
    au BufWinEnter *.txt,*.conf,.vimrc,*.notes silent loadview
    au BufWinEnter .vimrc set foldmethod=marker
    au FileType json set conceallevel=0
    au FileType make set diffopt-=iwhite
    au FileType vim set nospell
    au FileType mail set spell complete+=k nonu
    " par is much better at rewrapping mail
    au FileType mail if executable("par") | set formatprg=par | endif
    au FileType mail StripWhitespace
    au BufWinEnter *vimChatRoster, set foldlevel=1
    au BufWinEnter *.nse set filetype=lua
    " If a JS file has only one line, unminify it
    au FileType javascript if line('$')==1 | call Unminify() | endif
    au FileType help set nospell
    " What - like how does this even work
    au InsertLeave * hi! link CursorLine CursorLine
    au InsertEnter * hi! link CursorLine Normal
    " Disable the 'warning, editing a read-only file' thing that
    " hangs the UI
    au FileChangedRO * se noreadonly
    au GUIEnter * set visualbell t_vb=
augroup end

augroup syntax
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
augroup end

augroup icalednar
    au BufWinEnter *.ics set filetype=icalendar
augroup END

" }}}

" Custom functions {{{
" Quickfix toggle

function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

"nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
"nmap <silent> <leader>e :call ToggleList("Quickfix List", 'c')<CR>

command -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction

" Toggle Vexplore
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          "exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction

" wrap nicely
function! WrapMerge()
    set formatoptions-=w
    exec "normal gwip"
    set formatoptions+=w
endfunction

" clear quickfix
command -bar Qfc call setqflist([])

" Read in cookiefiles
command -bar Cookies call ReadCookies()
function ReadCookies()
    call system("cp Cookies.binarycookies /tmp/")
    %!python $HOME/bin/BinaryCookieReader.py /tmp/Cookies.binarycookies
endfunction

" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

" I use this to highlight the match from grep, but keep quickfix syntax
" highlighting intact. Detects Linux due to the different escape sequences of
" GNU grep.
command -bar GrepColors call GrepColors()
function GrepColors()
    set conceallevel=3
    set cocu=nv

    if system('uname')=~'Linux'
        syn region ansiRed start="\e\[01;31m"me=e-2 end="\e\[m"me=e-3 contains=ansiConceal
        syn match ansiConceal contained conceal	"\e\[\(\d*;\)*\d*m"
        syn match ansiStop		conceal "\e\[m"
    else
        syn region ansiRed start="\e\[01;31m\e\[K"me=e-2 end="\e\[m"me=e-3 contains=ansiConceal
        syn match ansiConceal contained conceal	"\e\[\(\d*;\)*\d*m\e\[K"
        syn match ansiStop		conceal "\e\[m\e\[K"
    endif

    hi ansiRed    ctermfg=197   guifg=#FF005F  cterm=none         gui=none
    hi! link ansiStop NONE
endfunction

" Simple re-format for minified Javascript
command! Unminify call Unminify()
function! Unminify()
    %s/{\ze[^\r\n]/{\r/g
    %s/){/) {/g
    %s/};\?\ze[^\r\n]/\0\r/g
    %s/;\ze[^\r\n]/;\r/g
    %s/[^\s]\zs[=&|]\+\ze[^\s]/ \0 /g
    normal ggVG=
endfunction

command! -nargs=1 Graudit call Graudit(<f-args>)
function! Graudit(db)
    call system("$HOME/Tools/graudit/graudit -x 'cscope.*' -c0 -d " . a:db . " . | awk 'length($0) < 200' > /tmp/graudit.out")
    copen
    cf /tmp/graudit.out
endfunction

" Delete trailing white space on save
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("Ag \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Make VIM remember position in file after reopen
if has("autocmd")
   au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Get currently selected text
function! s:get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][col1 - 1:]
    return join(lines, "\n")
endfunction

" Ack
" function! TAckRun(r,m)
"     if (a:m == "normal")
"         let curword = expand("<cword>")
"     elseif (a:m == "visual")
"         let curword = s:get_visual_selection()
"     endif
"     if (strlen(curword) == 0)
"         return
"     endif
"     execut  'Ack ' . a:r . ' ' . curword
" endfunction
" }}}


" Why do you turn this off
set hlsearch

" Underline the current line with dashes in normal mode
nnoremap <F5> yyp<c-v>$r-o<Esc>

" Underline the current line with dashes in insert mode
inoremap <F5> <Esc>yyp<c-v>$r-A<CR>

" ultisnips {{{
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsExpandTrigger="<c-n>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"  }}}

" In auto-complete menu, return selects highlighted
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" VimWiki {{{
let g:vimwiki_table_mappings = 0
autocmd FileType VimWiki setlocal spell
autocmd BufRead,BufNewFile *.wiki setlocal spell
"  }}}

" Keep at least 80 columns when opening tagbar
function! Min_width_tagbar()
    if winwidth('%') < 80 + g:tagbar_width
        let g:tagbar_expand = 2
        execute 'TagbarToggle'
        let g:tagbar_expand = 0
    else
        execute 'TagbarToggle'
    endif
endfunction

function! Mac_resize()
    if has("gui_macvim")
        if a:0 > 0
            call system('osascript -e "tell application \"MacVim\" to set the bounds of the front window to {'.trim(a:1).'}"')
            return 0
        else
            return system('osascript -e "tell application \"MacVim\" to get the bounds of the front window"')
        endif
    endif
    return 0
endfunction

" Automatically save the current session whenever vim is closed
function! MakeSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds

" Adding automations for when entering or leaving Vim
" if(argc() == 0)
"   au VimEnter * nested :call LoadSession()
" endif
" au VimLeavePre * :call MakeSession()

" URL encode/decode
vnoremap <silent> <leader>u :!python -c 'import sys,urllib;print urllib.quote(sys.stdin.read().strip())'<cr>
vnoremap <silent> <leader> :!python -c 'import sys,urllib;print urllib.unquote(sys.stdin.read().strip())'<cr>

" CtrlSF
" Prompt for search
nmap     <C-F><C-r> <Plug>CtrlSFPrompt
" Search for word under curosr
nmap     <C-F><C-f> <Plug>CtrlSFCwordExec
" Search for selected text
vmap     <C-F><C-f> <Plug>CtrlSFVwordExec
" Toggle search window
nnoremap <C-F><C-t> :CtrlSFToggle<CR>
" Toggle search window insert mode
inoremap <C-F><C-t> <Esc>:CtrlSFToggle<CR>
let g:ctrlsf_ackprg = '/usr/local/bin/rg' " Use rg
let g:ctrlsf_confirm_unsaving_quit = 0 " I don't plan on making changes
let g:ctrlsf_extra_root_markers = ['tags'] " Determine project root based on ctags file
let g:ctrlsf_default_root = 'project+fw' " Try to find root from current file, fall back to CWD
let g:ctrlsf_follow_symlinks = 0 " Don't follow symlinks
let g:ctrlsf_position = 'bottom' " Open on the bottom
let g:ctrlsf_winsize = '25%' " Don't be greedy
let g:ctrlsf_parse_speed = 200 " Don't overload vim
let g:ctrlsf_default_view_mode = 'compact' " quickfix style to start
" Auto focus when done, if it was fast
let g:ctrlsf_auto_focus = {
    \ "at" : "done",
    \ "duration_less_than": 1000
    \ }
" Customize key mappings
let g:ctrlsf_mapping = {
    \ "next": "n",
    \ "prev": "N",
    \ "pquit": "P",
    \ "popenf": "",
    \ }
" Close preview window from within search window
autocmd FileType ctrlsf map <silent> P :call ctrlsf#preview#ClosePreviewWindow()<CR>

" Toggle semantic highlighting
:nnoremap <F7> :SemanticHighlightToggle<CR>

" Work-specific vimrc
source ~/.vim/vimrc-work.vim
source ~/.vim/vimrc-apex.vim
