set mouse=a             " Turn this off for console-only mode
set selectmode-=mouse	  " Allow the mouse to enter visual mode
set cursorline          " Highlight current line, but slow

" Mode-dependent cursor (Mintty)
if has('win32') || has('win64')
    let &t_ti.="\e[1 q"
    let &t_SI.="\e[5 q"
    let &t_EI.="\e[1 q"
    let &t_te.="\e[0 q"
endif

" Ctrl-backspace to delete a word
imap  <C-w>
imap <C-BS> <C-w>

" for showing whitespace
func! ToggleList()
    if exists('g:list')
        exec ":set nolist"
    else
        exec ":set list"
    endif
endfunc
map <C-*> :call ToggleList()<CR>

" Fonts for gVIM
if has("gui_running")
    if has("gui_gtk2")
        set guifont=Inconsolata\ 10
    elseif has("gui_win32")
        set guifont=Consolas:h10:cANSI
    endif
endif

" Ctrl-s for saving when in gVIM
if has("gui_running")
    imap <C-s> <C-o>:update<CR>
    map <C-s> :update<CR>
endif

" Moved to ~/.vimrc
"if has('win32') || has('win64')
"    set runtimepath+=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
"endif

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

" ----- ack on current identifier in top level directory -----
if 1
    function! TAckRun(r,m)
        if (a:m == "normal")
            let curword = expand("<cword>")
        elseif (a:m == "visual")
            let curword = s:get_visual_selection()
        endif
        if (strlen(curword) == 0)
            return
        endif
        let oreport = &report
        let &report = 99999
        echo "Running ack " . a:r . curword
        new

        let s = 'perl \cygwin\usr\local\bin\ack --ignore-file=is:tags ' . a:r . curword
        execute "normal i" . s . "\<Esc>"
        execute '1read !' . s . ''
        2

        setlocal nomodified
        setlocal bufhidden=delete
        let &report = oreport
        setlocal nospell
    endfunction

    " Vim-Ack
    let g:ackprg="perl \\cygwin\\usr\\local\\bin\\ack --ignore-file=is:tags -H --nocolor --nogroup --column"

    function! TAckRun(r,m)
        if (a:m == "normal")
            let curword = expand("<cword>")
        elseif (a:m == "visual")
            let curword = s:get_visual_selection()
        endif
        if (strlen(curword) == 0)
            return
        endif
        execut  'Ack ' . a:r . ' ' . curword
    endfunction

    nnoremap _lg :call TAckRun(" ", "normal")<CR>
    nnoremap _lG :call TAckRun("-i ", "normal")<CR>
    vnoremap _lg :call TAckRun(" ", "visual")<CR>
    vnoremap _lG :call TAckRun("-i ", "visual")<CR>
endif

" ----- Edit file from 'lid' or 'grep -n' format -----
if 1
    " assume curbuf is lid or grep -n output.
    " format is ^file:line:text...
    function! LidEditFile()
        let curline = getline(".")
        let matchstart = match(curline, ':\d\+:')
        if matchstart >= 0
            let matchend = matchend(curline, ':\d\+:')
            let pos = strpart(curline, matchstart+1, (matchend-matchstart)-2)
            let fname = strpart(curline, 0, matchstart)
            execute 'split +' . pos . ' ' . fname
        endif
    endfunction

    nnoremap _le :call LidEditFile()<CR>
endif

" Detect TERM and set colors accordingly
set background=dark
colorscheme wombat256mod

" Colors in Ubuntu terminal
if $TERM == 'xterm'
    set t_Co=256
endif

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" CTRL-v in insert mode inserts * register without indent correction
imap <C-v> <C-r><C-o>*

" Search for selected text.
" http://vim.wikia.com/wiki/VimTip171
let s:save_cpo = &cpo | set cpo&vim
if !exists('g:VeryLiteral')
    let g:VeryLiteral = 0
endif

function! s:VSetSearch(cmd)
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    normal! gvy
    if @@ =~? '^[0-9a-z,_]*$' || @@ =~? '^[0-9a-z ,_]*$' && g:VeryLiteral
        let @/ = @@
    else
        let pat = escape(@@, a:cmd.'\')
        if g:VeryLiteral
            let pat = substitute(pat, '\n', '\\n', 'g')
        else
            let pat = substitute(pat, '^\_s\+', '\\s\\+', '')
            let pat = substitute(pat, '\_s\+$', '\\s\\*', '')
            let pat = substitute(pat, '\_s\+', '\\_s\\+', 'g')
        endif
        let @/ = '\V'.pat
    endif
    normal! gV
    call setreg('"', old_reg, old_regtype)
endfunction

vnoremap <silent> * :<C-U>call <SID>VSetSearch('/')<CR>/<C-R>/<CR>
vnoremap <silent> # :<C-U>call <SID>VSetSearch('?')<CR>?<C-R>/<CR>
vmap <kMultiply> *

nmap <silent> <Plug>VLToggle :let g:VeryLiteral = !g:VeryLiteral
            \\| echo "VeryLiteral " . (g:VeryLiteral ? "On" : "Off")<CR>
if !hasmapto("<Plug>VLToggle")
    nmap <unique> <Leader>vl <Plug>VLToggle
endif
let &cpo = s:save_cpo | unlet s:save_cpo
" END search for select text

" Adjust font size
nnoremap <C-Up> :silent! let &guifont = substitute(
            \ &guifont,
            \ ':h\zs\d\+',
            \ '\=eval(submatch(0)+1)',
            \ 'g')<CR>
nnoremap <C-Down> :silent! let &guifont = substitute(
            \ &guifont,
            \ ':h\zs\d\+',
            \ '\=eval(submatch(0)-1)',
            \ 'g')<CR>

"Select All
map <C-a> ggVG

" Height of the command bar
set cmdheight=1

" List buffers
"let g:airline#extensions#tabline#enabled = 1

" Wombat airline theme
let g:airline_theme="wombat"

" Undo amix_basic.vim's map [jk] (gj|gk)
unmap j
unmap k

" Silent VExplorer
map <F9> :silent call ToggleVExplorer()<CR>

" Default textwidth (to override amix's 500 setting)
set textwidth=80

" Line numbers
set number

" ctrl-PgUp/PgDn to switch buffers in normal mode
map [5;5~ :bn<cr>
map [6;5~ :bp<cr>
map <C-PageUp> :bn<cr>
map <C-PageDown> :bp<cr>

" Undo lxcode's left/right/home/end - I'm a Windows user at heart still
unmap <left>
unmap <right>
unmap <home>
unmap <end>

" Make, F6 because of TexStudio
map <silent> <F6> :w<CR> :!make<CR>
imap <silent> <F6> <ESC>:w<CR> :!make<CR>

" Open PDFs using 'start' on Windows
if has('win32') || has('win64')
    let g:LatexBox_viewer = "start"
endif

" I like CtrlP in file mode by default instead of mixed mode
let g:ctrlp_cmd = 'CtrlP'
map <Leader>e :CtrlPMixed<CR>

" Stop overriding the <c-p> mapping
let g:yankring_replace_n_pkey = ''
nmap <C-p> :call TogglePTag()<CR>

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

