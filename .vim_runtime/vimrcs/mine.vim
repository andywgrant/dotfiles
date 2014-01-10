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

if has('win32') || has('win64')
    set runtimepath+=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif


" ----- ack on current identifier in top level directory -----
if 1
    function! TAckRun(r)
        let curword = expand("<cword>")
        if (strlen(curword) == 0)
            return
        endif
        let oreport = &report
        let &report = 99999
        echo "Running ack " . a:r . curword
        new

        let s = 'perl \cygwin\usr\local\bin\ack --ignore-file=is:tags ' . a:r . curword . ' -r .'
        execute "normal i" . s . "\<Esc>"
        execute '1read !' . s . ''
        2

        setlocal nomodified
        setlocal bufhidden=delete
        let &report = oreport
        setlocal nospell
    endfunction

    nnoremap _lg :call TAckRun("-n ")<CR>
    nnoremap _lG :call TAckRun("-ni ")<CR>
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
let g:airline#extensions#tabline#enabled = 1

" Wombat airline theme
let g:airline_theme="wombat"

" Override amix_basic.vim's map [jk] (gj|gk)
map j j
map k k

" Silent VExplorer
map <F9> :silent call ToggleVExplorer()<CR>
