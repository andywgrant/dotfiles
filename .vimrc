set runtimepath+=~/.vim_runtime,~/.vim_runtime/amix-vim,~/.vim_runtime/lx-dotfiles/.vim
if has('win32') || has('win64')
    set runtimepath=$HOME/.vim,$HOME/.vim_runtime,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

source ~/.vim_runtime/amix-vim/vimrcs/basic.vim
source ~/.vim_runtime/amix-vim/vimrcs/filetypes.vim
source ~/.vim_runtime/amix-vim/vimrcs/plugins_config.vim
source ~/.vim_runtime/amix-vim/vimrcs/extended.vim
source ~/.vim_runtime/lx-dotfiles/.vimrc
source ~/.vim_runtime/vimrcs/mine.vim

