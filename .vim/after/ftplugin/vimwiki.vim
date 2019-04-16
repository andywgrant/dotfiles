" If we are on "*" at the beginning of a line, act like the cursor is on the
" first word when hitting Enter (i.e. follow links when on the list bullet)
" nnoremap <buffer> <CR> :call ListVimwikiFollowLink()<CR>
if !exists("*ListVimwikiFollowLink")
    function! ListVimwikiFollowLink()
        exe "normal 0"
        let currchar = matchstr(getline('.'), '\%' . col('.') . 'c.')
        let listlink = match(getline('.'), '[:space:]*\*')
        if listlink != -1
            if currchar == "*"
                exe "normal 0w"
                exe "VimwikiFollowLink"
            else 
                exe "normal f*w"
                exe "VimwikiFollowLink"
            endif
        else
            exe "VimwikiFollowLink"
        endif
    endfunction
endif
