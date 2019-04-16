" Vimwiki specific settings

" Render all wiki pages and open in browser
nmap <buffer> <Leader>whH :execute 'VimwikiAll2HTML' <bar> :Vimwiki2HTMLBrowse<CR>

" Add/Update TOC to every wiki page
" augroup vimwiki
"     au!
"     au BufWritePre *.wiki :VimwikiTOC
" augroup end
