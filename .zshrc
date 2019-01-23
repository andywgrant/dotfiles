# For use as Windows console
# Set up your zsh history
export HISTSIZE=1000
export HISTFILE=~/.zhistory
export SAVEHIST=1000

# Set up aliases
alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'       # no spelling correction on cp
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir
#alias j=jobs
#alias pu=pushd
#alias po=popd
#alias d='dirs -v'
#alias h=history
alias grep='egrep --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias ping='nocorrect ping'

# List only directories and symbolic
# links that point to directories
alias lsd='ls -ld *(-/DN)'

# List only file beginning with "."
alias lsa='ls -ld .*'

# Global aliases -- These do not have to be
# at the beginning of the command line.
alias -g M='|more'
alias -g H='|head'
alias -g T='|tail'

setopt autolist correctall automenu
#setopt pushdtohome pushdsilent #autopushd
setopt nolistbeep nobeep
#setopt notify monitor
setopt noclobber ignoreeof histignoredups autocd
#setopt winntignorecase

# Setup some basic programmable completions.  To see more examples
# of these, check Misc/compctl-examples in the zsh distribution.
compctl -g '*(-/)' cd pushd
compctl -g '*(/)' rmdir dircmp
compctl -j -P % -x 's[-] p[1]' -k signals -- kill
compctl -j -P % fg bg wait jobs disown
compctl -A shift
compctl -caF type whence which
compctl -F unfunction
compctl -a unalias
compctl -v unset typeset declare vared readonly export integer
compctl -e disable
compctl -d enable

# bindkey -v             # vi key bindings
bindkey -e               # emacs key bindings
bindkey ' ' magic-space  # also do history expansion on space

#bindkey ^W backward-delete-word

# taskwarrior tab completion
zstyle ':completion:*:*:task:*' verbose yes
zstyle ':completion:*:*:task:*:descriptions' format '%U%B%d%b%u'

zstyle ':completion:*:*:task:*' group-name ''

alias t=task
fpath=($fpath /usr/share/doc/task/scripts/zsh /usr/local/share/zsh/site-functions)

# be verbose, i.e. show descriptions
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'

# group by tag names
zstyle ':completion:*' group-name ''

autoload -Uz compinit
compinit -u

source ~/.prompt
cygwin_bash_prompt

bindkey  "^[[1~"    beginning-of-line
bindkey  "^[[4~"     end-of-line
bindkey  "^[[2~"  overwrite-mode
bindkey  "^[[3~"  delete-char
bindkey  "^[[5~"      up-line-or-history
bindkey  "^[[6~"    down-line-or-history
bindkey  "^[[D"    backward-char
bindkey  "^[[C"   forward-char

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

zstyle ':completion:*' list-colors ''

# list of completers to use
 zstyle ':completion:*::::' completer _expand _complete _ignored
#
# # allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
#zstyle ':completion:*:warnings' format 'No matches for: %d'
#zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*' list-colors ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists
zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'

# ssh hosts matching style
zstyle -e ':completion:*:hosts' hosts 'reply=($(cat $HOME/.ssh/known_hosts 2>/dev/null | sed -e "/^#/d" -e "s/ .*\$//" -e "s/,/ /g"))'


#{{{ Completion Stuff

bindkey -M viins '\C-i' complete-word

# Faster! (?)
zstyle ':completion::complete:*' use-cache 1

# case insensitive completion
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
#zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete
zstyle ':completion:*' completer _expand _force_rehash _complete _approximate _ignored

# generate descriptions with magic.
zstyle ':completion:*' auto-description 'specify: %d'

# Don't prompt for a huge list, page it!
#zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Don't prompt for a huge list, menu it!
#zstyle ':completion:*:default' menu 'select=0'

# Have the newer files last so I see them first
zstyle ':completion:*' file-sort modification reverse

# color code completion!!!!  Wohoo!
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"

unsetopt LIST_AMBIGUOUS
setopt  COMPLETE_IN_WORD

# Separate man page sections.  Neat.
zstyle ':completion:*:manuals' separate-sections true

# Egomaniac!
#zstyle ':completion:*' list-separator 'fREW'

# complete with a menu for xwindow ids
zstyle ':completion:*:windows' menu on=0
zstyle ':completion:*:expand:*' tag-order all-expansions

# more errors allowed for large words and fewer for small words
zstyle ':completion:*:approximate:*' max-errors 'reply=(  $((  ($#PREFIX+$#SUFFIX)/3  ))  )'

# Errors format
zstyle ':completion:*:corrections' format '%B%d (errors %e)%b'

# Don't complete stuff already on the line
zstyle ':completion::*:(rm|vi):*' ignore-line true

# Don't complete directory we are already in (../here)
zstyle ':completion:*' ignore-parents parent pwd

zstyle ':completion::approximate*:*' prefix-needed false

#}}}

stty stop undef

autoload -U select-word-style
select-word-style bash

alias ack='ack --ignore-file=is:tags'

export GOPATH="$HOME/go"
export PATH="$HOME/bin:$HOME/go/bin:/usr/local/bin:$PATH"
# path=(/usr/local/bin $path)
# path=($HOME/bin $path)

case $TERM in
    xterm*)
        precmd () {print -Pn "\033]0;%m: %~\007"}
        # Mac AutoJump
        [[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
        ;;
esac

case $TERM in
    cygwin)
        precmd () {print -Pn "\033];%m: %~\007"}
        preexec () { print -Pn "\e]0;$1\a" }
        # autojump
        fpath=($fpath ~/.autojump)
        source /cygdrive/c/Users/andy/.autojump/etc/profile.d/autojump.zsh
        alias start='cygstart'
        #alias vim='mintty vim'
        vim() {
            (mintty vim "$*" &) 2> /dev/null
        }

        gvim() {
            (/cygdrive/c/Program\ Files\ \(x86\)/Vim/vim74/gvim.exe "`cygpath -w $*`" &) 2> /dev/null
        }

        python() {
            (/cygdrive/c/python27/python `cygpath -w $1` $argv[2,-1])
        }

        export CYGWIN="nodosfilewarning"
        alias ls='ls --color'
        ;;
esac

# Locks down a thumb drive so that Mac OS X will not write any metadata to it.
macosx_lockdown_drive() {
    srm -r -s -v .Trashes
    touch .Trashes
    srm -r -s -v .fseventsd
    touch .fseventsd
    srm -r -s -v .Spotlight-V100
    touch .Spotlight-V100
    touch .metadata_never_index
}

export ANDROID_HOME=/usr/local/opt/android-sdk

fpath=(/usr/local/share/zsh-completions $fpath)

PERL_MB_OPT="--install_base \"/Users/agrant/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/agrant/perl5"; export PERL_MM_OPT;

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

# Homebrew hardening
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_CASK_OPTS=--require-sha
export PATH="/usr/local/sbin:$PATH"

# ripgrep for fzf
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
