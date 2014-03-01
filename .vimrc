set runtimepath+=~/.vim_runtime
if has('win32') || has('win64')
    set runtimepath=$HOME/.vim,$HOME/.vim_runtime,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

source ~/.vim_runtime/vimrcs/amix_basic.vim
source ~/.vim_runtime/vimrcs/amix_filetypes.vim
source ~/.vim_runtime/vimrcs/amix_plugins_config.vim
source ~/.vim_runtime/vimrcs/amix_extended.vim
source ~/.vim_runtime/vimrcs/lx.vim
source ~/.vim_runtime/vimrcs/mine.vim

